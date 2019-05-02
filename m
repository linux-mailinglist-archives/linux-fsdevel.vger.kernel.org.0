Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40F6F11EDB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 17:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfEBPlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 11:41:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfEBP2e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 11:28:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 630844DB12;
        Thu,  2 May 2019 15:28:33 +0000 (UTC)
Received: from [10.10.66.66] (ovpn-66-66.rdu2.redhat.com [10.10.66.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6508A60C05;
        Thu,  2 May 2019 15:28:32 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        abe@purdue.edu, lsof-l@lists.purdue.edu,
        util-linux@vger.kernel.org, jlayton@redhat.com
Subject: Re: [PATCH 09/10] nfsd: expose some more information about NFSv4
 opens
Date:   Thu, 02 May 2019 11:28:31 -0400
Message-ID: <786E0C83-A22D-461A-A9D1-AF7B42018CE9@redhat.com>
In-Reply-To: <1556201060-7947-10-git-send-email-bfields@redhat.com>
References: <1556201060-7947-1-git-send-email-bfields@redhat.com>
 <1556201060-7947-10-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 02 May 2019 15:28:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25 Apr 2019, at 10:04, J. Bruce Fields wrote:

> From: "J. Bruce Fields" <bfields@redhat.com>
>
> Add open modes, device numbers, inode numbers, and open owners to each
> line of nfsd/clients/#/opens.
>
> Open owners are totally opaque but seem to sometimes have some useful
> ascii strings included, so passing through printable ascii characters
> and escaping the rest seems useful while still being machine-readable.
> ---
>  fs/nfsd/nfs4state.c            | 40 
> ++++++++++++++++++++++++++++------
>  fs/nfsd/state.h                |  2 +-
>  fs/seq_file.c                  | 17 +++++++++++++++
>  include/linux/seq_file.h       |  2 ++
>  include/linux/string_helpers.h |  1 +
>  lib/string_helpers.c           |  5 +++--
>  6 files changed, 57 insertions(+), 10 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 829d1e5440d3..f53621a65e60 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -42,6 +42,7 @@
>  #include <linux/sunrpc/svcauth_gss.h>
>  #include <linux/sunrpc/addr.h>
>  #include <linux/jhash.h>
> +#include <linux/string_helpers.h>
>  #include "xdr4.h"
>  #include "xdr4cb.h"
>  #include "vfs.h"
> @@ -2261,16 +2262,41 @@ static void opens_stop(struct seq_file *s, 
> void *v)
>  static int opens_show(struct seq_file *s, void *v)
>  {
>  	struct nfs4_stid *st = v;
> -	struct nfs4_ol_stateid *os;
> -	u64 stateid;
> +	struct nfs4_ol_stateid *ols;
> +	struct nfs4_file *nf;
> +	struct file *file;
> +	struct inode *inode;
> +	struct nfs4_stateowner *oo;
> +	unsigned int access, deny;
>
>  	if (st->sc_type != NFS4_OPEN_STID)
>  		return 0; /* XXX: or SEQ_SKIP? */
> -	os = openlockstateid(st);
> -	/* XXX: get info about file, etc., here */
> +	ols = openlockstateid(st);
> +	oo = ols->st_stateowner;
> +	nf = st->sc_file;
> +	file = find_any_file(nf);
> +	inode = d_inode(file->f_path.dentry);
> +
> +	seq_printf(s, STATEID_FMT, STATEID_VAL(&st->sc_stateid));

Should we match the byte order printed with what wireshark/tshark sees?

For example, this will print:

5ccb016e/6d028c97/00000002/00000002 -w  --  fd:00:9163439   'open 
id:\x00\x00\x00.\x00\x00\x00\x00\x00\x00\x021\x8dp\xbe\xc7'

But, tshark -V prints:

         Opcode: OPEN (18)
             Status: NFS4_OK (0)
             stateid
                 [StateID Hash: 0x8298]
                 seqid: 0x00000002
                 Data: 6e01cb5c978c026d02000000
                 [Data hash (CRC-32): 0x8391069f]

I think this is the first time we've exposed state ids to users from 
knfsd,
I wonder if we should make it easier for everyone that might want to try 
to
correlate this information with what they can see in a packet capture.

Ben

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A01001200F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 18:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEBQYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 12:24:49 -0400
Received: from discipline.rit.edu ([129.21.6.207]:47161 "HELO
        discipline.rit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726381AbfEBQYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 12:24:49 -0400
Received: (qmail 84036 invoked by uid 501); 2 May 2019 15:58:06 -0000
From:   Andrew W Elble <aweits@rit.edu>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <abe@purdue.edu>, <lsof-l@lists.purdue.edu>,
        <util-linux@vger.kernel.org>, <jlayton@redhat.com>
Subject: Re: [PATCH 09/10] nfsd: expose some more information about NFSv4 opens
References: <1556201060-7947-1-git-send-email-bfields@redhat.com>
        <1556201060-7947-10-git-send-email-bfields@redhat.com>
        <786E0C83-A22D-461A-A9D1-AF7B42018CE9@redhat.com>
Date:   Thu, 02 May 2019 11:58:06 -0400
In-Reply-To: <786E0C83-A22D-461A-A9D1-AF7B42018CE9@redhat.com> (Benjamin
        Coddington's message of "Thu, 2 May 2019 11:28:31 -0400")
Message-ID: <m2k1f8hmr5.fsf@discipline.rit.edu>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (berkeley-unix)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Benjamin Coddington <bcodding@redhat.com> writes:

> On 25 Apr 2019, at 10:04, J. Bruce Fields wrote:
>
>> From: "J. Bruce Fields" <bfields@redhat.com>
>>
>> Add open modes, device numbers, inode numbers, and open owners to each
>> line of nfsd/clients/#/opens.
>>
>> Open owners are totally opaque but seem to sometimes have some useful
>> ascii strings included, so passing through printable ascii characters
>> and escaping the rest seems useful while still being machine-readable.
>> ---
>>  fs/nfsd/nfs4state.c            | 40
>> ++++++++++++++++++++++++++++------
>>  fs/nfsd/state.h                |  2 +-
>>  fs/seq_file.c                  | 17 +++++++++++++++
>>  include/linux/seq_file.h       |  2 ++
>>  include/linux/string_helpers.h |  1 +
>>  lib/string_helpers.c           |  5 +++--
>>  6 files changed, 57 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 829d1e5440d3..f53621a65e60 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -42,6 +42,7 @@
>>  #include <linux/sunrpc/svcauth_gss.h>
>>  #include <linux/sunrpc/addr.h>
>>  #include <linux/jhash.h>
>> +#include <linux/string_helpers.h>
>>  #include "xdr4.h"
>>  #include "xdr4cb.h"
>>  #include "vfs.h"
>> @@ -2261,16 +2262,41 @@ static void opens_stop(struct seq_file *s,
>> void *v)
>>  static int opens_show(struct seq_file *s, void *v)
>>  {
>>  	struct nfs4_stid *st = v;
>> -	struct nfs4_ol_stateid *os;
>> -	u64 stateid;
>> +	struct nfs4_ol_stateid *ols;
>> +	struct nfs4_file *nf;
>> +	struct file *file;
>> +	struct inode *inode;
>> +	struct nfs4_stateowner *oo;
>> +	unsigned int access, deny;
>>
>>  	if (st->sc_type != NFS4_OPEN_STID)
>>  		return 0; /* XXX: or SEQ_SKIP? */
>> -	os = openlockstateid(st);
>> -	/* XXX: get info about file, etc., here */
>> +	ols = openlockstateid(st);
>> +	oo = ols->st_stateowner;
>> +	nf = st->sc_file;
>> +	file = find_any_file(nf);

Is there a matching fput() missing somewhere, or did I just not see it...?

>> +	inode = d_inode(file->f_path.dentry);
>> +
>> +	seq_printf(s, STATEID_FMT, STATEID_VAL(&st->sc_stateid));
>
> Should we match the byte order printed with what wireshark/tshark sees?

^^ +1


Thanks,

Andy

-- 
Andrew W. Elble
Infrastructure Engineer
Information and Technology Services
Rochester Institute of Technology
tel: (585)-475-2411 | aweits@rit.edu
PGP: BFAD 8461 4CCF DC95 DA2C B0EB 965B 082E 863E C912

CONFIDENTIALITY NOTE: The information transmitted, including
attachments, is intended only for the person(s) or entity to which it
is addressed and may contain confidential and/or privileged material.
Any review, retransmission, dissemination or other use of, or taking of
any action in reliance upon this information by persons or entities
other than the intended recipient is prohibited. If you received this
in error, please contact the sender and destroy any copies of this
information.

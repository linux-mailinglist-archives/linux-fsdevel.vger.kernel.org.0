Return-Path: <linux-fsdevel+bounces-8122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8472082FD04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 23:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9980D1C2821A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC31605A7;
	Tue, 16 Jan 2024 22:07:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991F2604C3;
	Tue, 16 Jan 2024 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442842; cv=none; b=mxA/fBe0P7/k1b/gR4jrApKQvmo2A/g4J4NaB5GXODTEbtUlFeVYyEfSykWWeU87L/JW3I2KM+CXz2r2K1T9i0crFFVtmQWPE1TK83fq/r1OTnpAYlwCfzA2aNbAOgYg1WsWlZxn85NRsC1cQz0PcCJEYS0DaXwPRnFRz6raDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442842; c=relaxed/simple;
	bh=IYYnR2EFburvoZquoTc+yWa7KgPsEyYwG1E6dao281I=;
	h=Received:Received:Received:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:From:To:Cc:Subject:In-reply-to:References:Date:
	 Message-id:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Spam-Score:X-Spam-Flag; b=pDF6nvhUZZq3diTsTd1xPhM1zGrgIy4BzgfRcKZKyhhZW8ye8fSbyg7NuJIU2ye13gL69oO2YSqpXR+85pE6OMgaSIZy2M/TKCmL+snyjGwgJIEr0puHO5M+9Tfhy5vYPmc08w2RBJGUCt5TJCzn0riVgvXPKwziVEucDK032Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7C1322168;
	Tue, 16 Jan 2024 22:07:18 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BB4613751;
	Tue, 16 Jan 2024 22:07:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0xBrNAj+pmWWeAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 16 Jan 2024 22:07:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>,
 "Dominique Martinet" <asmadeus@codewreck.org>,
 "Christian Schoenebeck" <linux_oss@crudebyte.com>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Alexander Aring" <aahringo@redhat.com>,
 "David Teigland" <teigland@redhat.com>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Jan Kara" <jack@suse.cz>,
 "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>, "Steve French" <sfrench@samba.org>,
 "Paulo Alcantara" <pc@manguebit.com>, "Ronnie Sahlberg" <lsahlber@redhat.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-trace-kernel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH 01/20] filelock: split common fields into struct file_lock_core
In-reply-to: <20240116-flsplit-v1-1-c9d0f4370a5d@kernel.org>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>,
 <20240116-flsplit-v1-1-c9d0f4370a5d@kernel.org>
Date: Wed, 17 Jan 2024 09:07:02 +1100
Message-id: <170544282220.23031.10628392788633554158@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B7C1322168
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, 17 Jan 2024, Jeff Layton wrote:
> In a future patch, we're going to split file leases into their own
> structure. Since a lot of the underlying machinery uses the same fields
> move those into a new file_lock_core, and embed that inside struct
> file_lock.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/filelock.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 95e868e09e29..7825511c1c11 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -85,8 +85,9 @@ bool opens_in_grace(struct net *);
>   *
>   * Obviously, the last two criteria only matter for POSIX locks.
>   */
> -struct file_lock {
> -	struct file_lock *fl_blocker;	/* The lock, that is blocking us */
> +
> +struct file_lock_core {
> +	struct file_lock *fl_blocker;	/* The lock that is blocking us */
>  	struct list_head fl_list;	/* link into file_lock_context */
>  	struct hlist_node fl_link;	/* node in global lists */
>  	struct list_head fl_blocked_requests;	/* list of requests with
> @@ -102,6 +103,10 @@ struct file_lock {
>  	int fl_link_cpu;		/* what cpu's list is this on? */
>  	wait_queue_head_t fl_wait;
>  	struct file *fl_file;
> +};
> +
> +struct file_lock {
> +	struct file_lock_core fl_core;
>  	loff_t fl_start;
>  	loff_t fl_end;
>  

If I we doing this, I would rename all the fields in file_lock_core to
have an "flc_" prefix, and add some #defines like

 #define fl_list fl_core.flc_list

so there would be no need to squash this with later patches to achieve
bisectability.

The #defines would be removed after the coccinelle scripts etc are
applied.

I would also do the "convert some internal functions" patches *before*
the bulk conversion of fl_foo to fl_code.flc_foo so that those functions
don't get patched twice.

But this is all personal preference.  If you prefer your approach,
please leave it that way.  The only clear benefit of my approach is that
you don't need to squash patches together, and that is probably not a
big deal.

Thanks,
NeilBrown


Return-Path: <linux-fsdevel+bounces-9939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D439A8463D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522D41F28AD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319F346433;
	Thu,  1 Feb 2024 22:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZikCwOfQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="42Wd/tDk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZikCwOfQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="42Wd/tDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558445BF6;
	Thu,  1 Feb 2024 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827790; cv=none; b=nI2RHTc7qekgyfejmIdSsRqJ3HoO2fzLlMNoNFDKExlAifJJcwK2icYJzOh08JGKLfBWl/sIWcfKXYo6fT4/uelj0d5Wt18ToGDMuZ2nCNucp0yefRop6YMS169qY2bx8TC9/wIErh3O/emMrHhGxQu0isLkyEFxENK1n+SJ4I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827790; c=relaxed/simple;
	bh=x9ZhYMkj/aa+ezAniKGau1L1wNsh5jGEb6UhbI+rWK0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ptBuDtIzA1MefGrA3rcmHLfBqtfxCD0VN8fO8QH5lJhv6cibK15cZ+tfhn1pc7+2fN+MwCt1Sr4dRD4iOyAhw+Q0VPYcLLqxpA0KXT3Or/l0FmAsYg8IYHwIR9FFuLM09j0lMP5h4N1XiQXp7mO5NRskYG1Avuqwrg4RUi85h88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZikCwOfQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=42Wd/tDk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZikCwOfQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=42Wd/tDk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F8AB1FC2A;
	Thu,  1 Feb 2024 22:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706827785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7pHjYgoT7uzw4oaYjtctwuPeVz4bbHKhCV0HwFPxFmM=;
	b=ZikCwOfQRWIvGmZintbhuLmKpO3x/YkFdnE+Hh3GzMP34NXJMoEVSTRyo6fP7m3I7cFy0s
	GvaEfWebvHzTS0AytYB2NbWZx5f+E40Ymmf/WXJZR7o6WCc16m2trt2AL7mNIBXMqDz4Xy
	uhy2CU9UtKW9c11OMw0/MHWFFNOg96s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706827785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7pHjYgoT7uzw4oaYjtctwuPeVz4bbHKhCV0HwFPxFmM=;
	b=42Wd/tDkkJmkv/D/MGpFdMv+OZ8y03F/rFaMxiF4ctMtNLzFeYOtjO4HxX7xP6MoVkAjRv
	Oi+0zcUwUkdoSnBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706827785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7pHjYgoT7uzw4oaYjtctwuPeVz4bbHKhCV0HwFPxFmM=;
	b=ZikCwOfQRWIvGmZintbhuLmKpO3x/YkFdnE+Hh3GzMP34NXJMoEVSTRyo6fP7m3I7cFy0s
	GvaEfWebvHzTS0AytYB2NbWZx5f+E40Ymmf/WXJZR7o6WCc16m2trt2AL7mNIBXMqDz4Xy
	uhy2CU9UtKW9c11OMw0/MHWFFNOg96s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706827785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7pHjYgoT7uzw4oaYjtctwuPeVz4bbHKhCV0HwFPxFmM=;
	b=42Wd/tDkkJmkv/D/MGpFdMv+OZ8y03F/rFaMxiF4ctMtNLzFeYOtjO4HxX7xP6MoVkAjRv
	Oi+0zcUwUkdoSnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6717A139AB;
	Thu,  1 Feb 2024 22:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jLyIB/wfvGWUawAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 01 Feb 2024 22:49:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>,
 "Dominique Martinet" <asmadeus@codewreck.org>,
 "Christian Schoenebeck" <linux_oss@crudebyte.com>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Alexander Aring" <aahringo@redhat.com>,
 "David Teigland" <teigland@redhat.com>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>, "Mark Fasheh" <mark@fasheh.com>,
 "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.com>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH v3 00/47] filelock: split file leases out of struct file_lock
In-reply-to: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
Date: Fri, 02 Feb 2024 09:49:29 +1100
Message-id: <170682776950.13976.8032076527553420784@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZikCwOfQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="42Wd/tDk"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 R_RATELIMIT(0.00)[to_ip_from(RLouahofup1mwqksbidco3ksry)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[45];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[goodmis.org,kernel.org,efficios.com,oracle.com,zeniv.linux.org.uk,suse.cz,ionkov.net,codewreck.org,crudebyte.com,redhat.com,auristor.com,gmail.com,netapp.com,talpey.com,hammerspace.com,fasheh.com,evilplan.org,linux.alibaba.com,samba.org,manguebit.com,microsoft.com,chromium.org,szeredi.hu,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: 7F8AB1FC2A
X-Spam-Flag: NO

On Thu, 01 Feb 2024, Jeff Layton wrote:
> I'm not sure this is much prettier than the last, but contracting
> "fl_core" to "c", as Neil suggested is a bit easier on the eyes.
>=20
> I also added a few small helpers and converted several users over to
> them. That reduces the size of the per-fs conversion patches later in
> the series. I played with some others too, but they were too awkward
> or not frequently used enough to make it worthwhile.
>=20
> Many thanks to Chuck and Neil for the earlier R-b's and comments. I've
> dropped those for now since this set is a bit different from the last.
>=20
> I'd like to get this into linux-next soon and we can see about merging
> it for v6.9, unless anyone has major objections.

For all patches:
  Reviewed-by: NeilBrown <neilb@suse.de>

Thanks Jeff - I think this is a good and useful change and while it
might not all be as pretty as I might like, I don't see any way to
improve it and think it is certainly good enough to merge.

I think the conversion from "fl_core" to "c" does work well enough.
I particularly like how the removal of the IS_* macros (patch 16) turned
out.  The inline expansion of IS_LEASE() in particular makes the code
clearer to me.

Thanks,
NeilBrown


>=20
> Thanks!
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v3:
> - Rename "flc_core" fields in file_lock and file_lease to "c"
> - new helpers: locks_wake_up, for_each_file_lock, and lock_is_{unlock,read,=
write}
> - Link to v2: https://lore.kernel.org/r/20240125-flsplit-v2-0-7485322b62c7@=
kernel.org
>=20
> Changes in v2:
> - renamed file_lock_core fields to have "flc_" prefix
> - used macros to more easily do the change piecemeal
> - broke up patches into per-subsystem ones
> - Link to v1: https://lore.kernel.org/r/20240116-flsplit-v1-0-c9d0f4370a5d@=
kernel.org
>=20
> ---
> Jeff Layton (47):
>       filelock: fl_pid field should be signed int
>       filelock: rename some fields in tracepoints
>       filelock: rename fl_pid variable in lock_get_status
>       filelock: add some new helper functions
>       9p: rename fl_type variable in v9fs_file_do_lock
>       afs: convert to using new filelock helpers
>       ceph: convert to using new filelock helpers
>       dlm: convert to using new filelock helpers
>       gfs2: convert to using new filelock helpers
>       lockd: convert to using new filelock helpers
>       nfs: convert to using new filelock helpers
>       nfsd: convert to using new filelock helpers
>       ocfs2: convert to using new filelock helpers
>       smb/client: convert to using new filelock helpers
>       smb/server: convert to using new filelock helpers
>       filelock: drop the IS_* macros
>       filelock: split common fields into struct file_lock_core
>       filelock: have fs/locks.c deal with file_lock_core directly
>       filelock: convert more internal functions to use file_lock_core
>       filelock: make posix_same_owner take file_lock_core pointers
>       filelock: convert posix_owner_key to take file_lock_core arg
>       filelock: make locks_{insert,delete}_global_locks take file_lock_core=
 arg
>       filelock: convert locks_{insert,delete}_global_blocked
>       filelock: make __locks_delete_block and __locks_wake_up_blocks take f=
ile_lock_core
>       filelock: convert __locks_insert_block, conflict and deadlock checks =
to use file_lock_core
>       filelock: convert fl_blocker to file_lock_core
>       filelock: clean up locks_delete_block internals
>       filelock: reorganize locks_delete_block and __locks_insert_block
>       filelock: make assign_type helper take a file_lock_core pointer
>       filelock: convert locks_wake_up_blocks to take a file_lock_core point=
er
>       filelock: convert locks_insert_lock_ctx and locks_delete_lock_ctx
>       filelock: convert locks_translate_pid to take file_lock_core
>       filelock: convert seqfile handling to use file_lock_core
>       9p: adapt to breakup of struct file_lock
>       afs: adapt to breakup of struct file_lock
>       ceph: adapt to breakup of struct file_lock
>       dlm: adapt to breakup of struct file_lock
>       gfs2: adapt to breakup of struct file_lock
>       fuse: adapt to breakup of struct file_lock
>       lockd: adapt to breakup of struct file_lock
>       nfs: adapt to breakup of struct file_lock
>       nfsd: adapt to breakup of struct file_lock
>       ocfs2: adapt to breakup of struct file_lock
>       smb/client: adapt to breakup of struct file_lock
>       smb/server: adapt to breakup of struct file_lock
>       filelock: remove temporary compatibility macros
>       filelock: split leases out of struct file_lock
>=20
>  fs/9p/vfs_file.c                |  40 +-
>  fs/afs/flock.c                  |  60 +--
>  fs/ceph/locks.c                 |  74 ++--
>  fs/dlm/plock.c                  |  44 +--
>  fs/fuse/file.c                  |  14 +-
>  fs/gfs2/file.c                  |  16 +-
>  fs/libfs.c                      |   2 +-
>  fs/lockd/clnt4xdr.c             |  14 +-
>  fs/lockd/clntlock.c             |   2 +-
>  fs/lockd/clntproc.c             |  65 +--
>  fs/lockd/clntxdr.c              |  14 +-
>  fs/lockd/svc4proc.c             |  10 +-
>  fs/lockd/svclock.c              |  64 +--
>  fs/lockd/svcproc.c              |  10 +-
>  fs/lockd/svcsubs.c              |  24 +-
>  fs/lockd/xdr.c                  |  14 +-
>  fs/lockd/xdr4.c                 |  14 +-
>  fs/locks.c                      | 851 ++++++++++++++++++++++--------------=
----
>  fs/nfs/delegation.c             |   4 +-
>  fs/nfs/file.c                   |  22 +-
>  fs/nfs/nfs3proc.c               |   2 +-
>  fs/nfs/nfs4_fs.h                |   2 +-
>  fs/nfs/nfs4file.c               |   2 +-
>  fs/nfs/nfs4proc.c               |  39 +-
>  fs/nfs/nfs4state.c              |  22 +-
>  fs/nfs/nfs4trace.h              |   4 +-
>  fs/nfs/nfs4xdr.c                |   8 +-
>  fs/nfs/write.c                  |   8 +-
>  fs/nfsd/filecache.c             |   4 +-
>  fs/nfsd/nfs4callback.c          |   2 +-
>  fs/nfsd/nfs4layouts.c           |  34 +-
>  fs/nfsd/nfs4state.c             | 120 +++---
>  fs/ocfs2/locks.c                |  12 +-
>  fs/ocfs2/stack_user.c           |   2 +-
>  fs/open.c                       |   2 +-
>  fs/posix_acl.c                  |   4 +-
>  fs/smb/client/cifsfs.c          |   2 +-
>  fs/smb/client/cifssmb.c         |   8 +-
>  fs/smb/client/file.c            |  78 ++--
>  fs/smb/client/smb2file.c        |   2 +-
>  fs/smb/server/smb2pdu.c         |  44 +--
>  fs/smb/server/vfs.c             |  14 +-
>  include/linux/filelock.h        | 103 +++--
>  include/linux/fs.h              |   5 +-
>  include/linux/lockd/lockd.h     |   8 +-
>  include/linux/lockd/xdr.h       |   2 +-
>  include/trace/events/afs.h      |   4 +-
>  include/trace/events/filelock.h | 102 ++---
>  48 files changed, 1064 insertions(+), 933 deletions(-)
> ---
> base-commit: e96efe9f69ebb12b38c722c159413fd6850b782c
> change-id: 20240116-flsplit-bdb46824db68
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20



Return-Path: <linux-fsdevel+bounces-79177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDnLMZO/pmlDTQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 12:01:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A61ED417
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 12:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFB923036A89
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E1A3D1CC5;
	Tue,  3 Mar 2026 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsjAVrLm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758C73CB2CC
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535402; cv=none; b=qYNf8CPmGYZO9QEVbMzUzgX2GvXDs4oV6rzWXHXnoD747ks7l+nNfY1FGNj4WxCMFXW/a9A8cea3JqVz5sySYNWmTrabXj95V5rzyylU7Jh/dgzLnDthWpdS+is8Uly+rhtdx9TbgDDiXI1GLx92iaCa1kSWzW5FrmR71oHTiII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535402; c=relaxed/simple;
	bh=ZJFR9/2OtrcnrgSTa4EHnH5JX9DBPEZCrlsYG5puECk=;
	h=From:In-Reply-To:References:To:cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=GugdT32DUIQxYdf7NAtwfhIuB9fPEROmcNeZBjZ1b9Jp0hknxYmmyvrmosbJFh3Pl0xGvdkjTxUEbh2dPvlAengchRKbuka6yTRTbxZONqhN2qN6ldMHnmU82gYDAZcthlReWGZlyoEY6yHk3thxGILYa3V/TkBUIB6LWDnEUo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MsjAVrLm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772535395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lQfcYf0nTgw81P/IsIDOOQjFjTNPUrLYna+XMlLw958=;
	b=MsjAVrLmlvCsfeLEz90fkDnjAwLfwkvNtqGeaCXkyrSHROEDwFBC4bLuvVtSr3W8Ef7Jlg
	bgMs6E/NfnNigL/U/8c98gIPOZGsB3L+DnTFNSRcBaZwb37c+zXQ+rehAhQA1yr0r5Jn8D
	6I0yThH5IiyukhqNQ6xa4XBLdp3h1ZE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-9DLAvm1NMyeHwtyl5RgUtw-1; Tue,
 03 Mar 2026 05:56:31 -0500
X-MC-Unique: 9DLAvm1NMyeHwtyl5RgUtw-1
X-Mimecast-MFC-AGG-ID: 9DLAvm1NMyeHwtyl5RgUtw_1772535386
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE23D19560B0;
	Tue,  3 Mar 2026 10:56:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.249])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3DC31800672;
	Tue,  3 Mar 2026 10:55:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
    Steven Rostedt <rostedt@goodmis.org>,
    Masami Hiramatsu <mhiramat@kernel.org>,
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
    Dan Williams <dan.j.williams@intel.com>,
    Matthew Wilcox <willy@infradead.org>,
    Eric Biggers <ebiggers@kernel.org>,
    "Theodore Y. Ts'o" <tytso@mit.edu>,
    Muchun Song <muchun.song@linux.dev>,
    Oscar Salvador <osalvador@suse.de>,
    David Hildenbrand <david@kernel.org>,
    David Howells <dhowells@redhat.com>,
    Paulo Alcantara <pc@manguebit.org>,
    Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
    Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
    Trond Myklebust <trondmy@kernel.org>,
    Anna Schumaker <anna@kernel.org>,
    Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
    Olga Kornievskaia <okorniev@redhat.com>,
    Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
    Steve French <sfrench@samba.org>,
    Ronnie Sahlberg <ronniesahlberg@gmail.com>,
    Shyam Prasad N <sprasad@microsoft.com>,
    Bharath SM <bharathsm@microsoft.com>,
    Alexander Aring <alex.aring@gmail.com>,
    Ryusuke Konishi <konishi.ryusuke@gmail.com>,
    Viacheslav Dubeyko <slava@dubeyko.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    David Sterba <dsterba@suse.com>,
    Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>,
    Luis de Bethencourt <luisbg@kernel.org>,
    Salah Triki <salah.triki@gmail.com>,
    "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
    Ilya Dryomov <idryomov@gmail.com>,
    Alex Markuze <amarkuze@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
    coda@cs.cmu.edu, Nicolas Pitre <nico@fluxnic.net>,
    Tyler Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>,
    Christoph Hellwig <hch@infradead.org>,
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
    Yangtao Li <frank.li@vivo.com>,
    Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
    David Woodhouse <dwmw2@infradead.org>,
    Richard Weinberger <richard@nod.at>,
    Dave Kleikamp <shaggy@kernel.org>,
    Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
    Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
    Joseph Qi <joseph.qi@linux.alibaba.com>,
    Mike Marshall <hubcap@omnibond.com>,
    Martin Brandenburg <martin@omnibond.com>,
    Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>,
    Zhihao Cheng <chengzhihao1@huawei.com>,
    Damien Le Moal <dlemoal@kernel.org>,
    Naohiro Aota <naohiro.aota@wdc.com>,
    Johannes Thumshirn <jth@kernel.org>,
    John Johansen <john.johansen@canonical.com>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    Mimi Zohar <zohar@linux.ibm.com>,
    Roberto Sassu <roberto.sassu@huawei.com>,
    Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
    Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>,
    Stephen Smalley <stephen.smalley.work@gmail.com>,
    Ondrej Mosnacek <omosnace@redhat.com>,
    Casey Schaufler <casey@schaufler-ca.com>,
    Alex Deucher <alexander.deucher@amd.com>,
    Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
    David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
    Sumit Semwal <sumit.semwal@linaro.org>,
    Eric Dumazet <edumazet@google.com>,
    Kuniyuki Iwashima <kuniyu@google.com>,
    Paolo Abeni <pabeni@redhat.com>,
    Willem de Bruijn <willemb@google.com>,
    "David S. Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
    Oleg Nesterov <oleg@redhat.com>,
    Peter Zijlstra <peterz@infradead.org>,
    Ingo Molnar <mingo@redhat.com>,
    Arnaldo Carvalho de Melo <acme@kernel.org>,
    Namhyung Kim <namhyung@kernel.org>,
    Mark Rutland <mark.rutland@arm.com>,
    Alexander Shishkin <alexander.shishkin@linux.intel.com>,
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
    Adrian Hunter <adrian.hunter@intel.com>,
    James Clark <james.clark@linaro.org>,
    "Darrick J. Wong" <djwong@kernel.org>,
    Martin Schiller <ms@dev.tdt.de>, Eric Paris <eparis@redhat.com>,
    Joerg Reuter <jreuter@yaina.de>,
    Marcel Holtmann <marcel@holtmann.org>,
    Johan Hedberg <johan.hedberg@gmail.com>,
    Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
    Oliver Hartkopp <socketcan@hartkopp.net>,
    Marc Kleine-Budde <mkl@pengutronix.de>,
    David Ahern <dsahern@kernel.org>,
    Neal Cardwell <ncardwell@google.com>,
    Steffen Klassert <steffen.klassert@secunet.com>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Remi Denis-Courmont <courmisch@gmail.com>,
    Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
    Xin Long <lucien.xin@gmail.com>,
    Magnus Karlsson <magnus.karlsson@intel.com>,
    Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
    Stanislav Fomichev <sdf@fomichev.me>,
    Alexei Starovoitov <ast@kernel.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Jesper Dangaard Brouer <hawk@kernel.org>,
    John Fastabend <john.fastabend@gmail.com>,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
    fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev,
    linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
    linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
    samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    autofs@vger.kernel.org, ceph-devel@vger.kernel.org,
    codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
    linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
    ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
    devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
    apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
    linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
    amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
    linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
    netdev@vger.kernel.org, linux-perf-users@vger.kernel.org,
    linux-fscrypt@vger.kernel.org, linux-xfs@vger.kernel.org,
    linux-hams@vger.kernel.org, linux-x25@vger.kernel.org,
    audit@vger.kernel.org, linux-bluetooth@vger.kernel.org,
    linux-can@vger.kernel.org, linux-sctp@vger.kernel.org,
    bpf@vger.kernel.org
Subject: Re: [PATCH v2 000/110] vfs: change inode->i_ino from unsigned long to u64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Date: Tue, 03 Mar 2026 10:55:32 +0000
Message-ID: <1787281.1772535332@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 632A61ED417
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.or
 g];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79177-lists,linux-fsdevel=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[172];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,warthog.procyon.org.uk:mid]
X-Rspamd-Action: no action

Jeff Layton <jlayton@kernel.org> wrote:

> This version splits the change up to be more bisectable. It first adds a
> new kino_t typedef and a new "PRIino" macro to hold the width specifier
> for format strings. The conversion is done, and then everything is
> changed to remove the new macro and typedef.

Why remove the typedef?  It might be better to keep it.

David



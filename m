Return-Path: <linux-fsdevel+bounces-28187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767A6967CBD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 01:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDFF281A50
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 23:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DCA1581E5;
	Sun,  1 Sep 2024 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="meR0a0sk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HxJ0GqkM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="meR0a0sk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HxJ0GqkM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236561CAB9;
	Sun,  1 Sep 2024 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725233166; cv=none; b=VOrsSu/nj9LnpwiPBvFEVK0ncs2Oiqc+Kd4OVWttT+YZjIXofUhkAGW/se+L8OyCHUnZVHJanBlUwL+mosohZZxf4Q5x/SvyKTek4t5A588FX3Io+9Ojzp7ZGW0I1q58fcdmJDW3Hzkrmbwlzi/vO/5x3ez1NvAAGLowvRCg9fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725233166; c=relaxed/simple;
	bh=OukL/m+NwppRMzUKnYH33rogr1UvaostXWTu2B7U/c8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=k5aj9Hh45MFDgvm1xugDr41uzWaHAw1bOo2ZtTYVU4Me3VPDhgd7vsafZQE/9gIfhdrIVar41JxdGE9FB4Ju5/zXAfI3nV8Pj1XZdF5Zt7W3pvv+qG/1wZNBI+lziDX2N3h1PmzY1u/wm/NUSnTYX5/tRSYrLPNTISIRNswsiLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=meR0a0sk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HxJ0GqkM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=meR0a0sk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HxJ0GqkM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3224D21B17;
	Sun,  1 Sep 2024 23:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725233162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zm2Oxng+xsr0KAXAO+T8XMfMMVLgl4YRdxA9JFuGcY=;
	b=meR0a0skL+mmRo8MadtxyYrrNTbNgCFeb/u2m408qgdm+jvBWWwNuQodKCoqlzrzuq/n44
	AkXsrJLzApL8xN6nHNdQr2haQU3JKPD7wh69O5sykBr5HSBSXmI6LTiu0C0RBqFzk6Y5dU
	KTLivzP+f4sO1N0Szg+2ZAY6gghd6Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725233162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zm2Oxng+xsr0KAXAO+T8XMfMMVLgl4YRdxA9JFuGcY=;
	b=HxJ0GqkMSB6j3pdMosUleUNqKMI1TOmX+TJjKV9hZRnnYvClIB//lbBB1lOhzIHVF5d7h1
	UQL1zP6ht0bQVzDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725233162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zm2Oxng+xsr0KAXAO+T8XMfMMVLgl4YRdxA9JFuGcY=;
	b=meR0a0skL+mmRo8MadtxyYrrNTbNgCFeb/u2m408qgdm+jvBWWwNuQodKCoqlzrzuq/n44
	AkXsrJLzApL8xN6nHNdQr2haQU3JKPD7wh69O5sykBr5HSBSXmI6LTiu0C0RBqFzk6Y5dU
	KTLivzP+f4sO1N0Szg+2ZAY6gghd6Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725233162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zm2Oxng+xsr0KAXAO+T8XMfMMVLgl4YRdxA9JFuGcY=;
	b=HxJ0GqkMSB6j3pdMosUleUNqKMI1TOmX+TJjKV9hZRnnYvClIB//lbBB1lOhzIHVF5d7h1
	UQL1zP6ht0bQVzDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1D511373A;
	Sun,  1 Sep 2024 23:25:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Uj8hHQf41GZwLAAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 01 Sep 2024 23:25:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 14/26] nfs_common: add NFS LOCALIO auxiliary protocol
 enablement
In-reply-to: <20240831223755.8569-15-snitzer@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>,
 <20240831223755.8569-15-snitzer@kernel.org>
Date: Mon, 02 Sep 2024 09:25:52 +1000
Message-id: <172523315282.4433.12624168004076761213@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[noble.neil.brown.name:mid];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 01 Sep 2024, Mike Snitzer wrote:
> fs/nfs_common/nfslocalio.c provides interfaces that enable an NFS
> client to generate a nonce (single-use UUID) and associated
> short-lived nfs_uuid_t struct, register it with nfs_common for
> subsequent lookup and verification by the NFS server and if matched
> the NFS server populates members in the nfs_uuid_t struct.

The nfs_uuid_t isn't short-lived any more.  It will be embedded in the
struct nfs_client.  I think I revised that comment in one of the patches
I sent...

Thanks,
NeilBrown


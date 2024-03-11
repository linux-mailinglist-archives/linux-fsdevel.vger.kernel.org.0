Return-Path: <linux-fsdevel+bounces-14119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B7877E26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 11:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B9C1C21571
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 10:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAED036AEF;
	Mon, 11 Mar 2024 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yGR6nELI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BKUVLWvg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TE1SX6Jd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L81a4abe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE5E29424;
	Mon, 11 Mar 2024 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153295; cv=none; b=ZyB7F33S2apDF2OopjH48yzwSX6meOJHfaZqBD9AC0EWMnnh6UZ1jbzu4kmYCQ6rcdr+fqO/tfpauvHOaQTAGveeSdkbyFt4MMxvH+yHyw1znbyRdPaQSc3t8wkAtMTqBMWZNQo0DP0G2oukCI/DjMdHEnZg/OIM6R73cY4HUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153295; c=relaxed/simple;
	bh=X+HtUsSy0SsHLYpr4duKeXx/uQDdTXe2F5bSIirV2ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bKRRhnPSSXYw29PUn8Snv37JMuN/tBSWbbchlemg3sbOHOX5Xc+g3PqhlBjDo4flmLU9JaqPDOrXyxHQBJJAtlkad7/TRnZQMZj21v8boVdLwAyaNs3yU2S6kVNS0fUGxaZG4F8hz82J1Oge3ZOVs8MKVWQfhBiQ9VUqCW1oagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yGR6nELI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BKUVLWvg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TE1SX6Jd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L81a4abe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E53AB34B28;
	Mon, 11 Mar 2024 10:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710153292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qax2WgVEIe4KLArEJwT0DggITTN6Jz8gZ/p1hvzV2tI=;
	b=yGR6nELI6hOH5MPWVgsw4rI3LWF2zaQWXbhKv1715YP9ev2Iqj2+hwyZh9qbYzzLoNkXXf
	ZFfVyMBhQ9mW2t5FFMNO+8LShSQBNaVb7jmIeZceESsJlABc6jgISJs8KyDFOMLR6/iM7W
	NEGuGJYTgV5i0V/ICGHrL5rA2l3mpRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710153292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qax2WgVEIe4KLArEJwT0DggITTN6Jz8gZ/p1hvzV2tI=;
	b=BKUVLWvgY1TcqZxaLvR9cTPLgsywPgd/Bnsdv3bioQHTkb2MNVVqFDWOCZD9OLB4QCJAhn
	/833gD2IRLL4nbCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710153290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qax2WgVEIe4KLArEJwT0DggITTN6Jz8gZ/p1hvzV2tI=;
	b=TE1SX6Jd5KPAyY3VJFHXC74k7jEn1LP88fAr96ZTrf57Q7NkIjKEfRwYy4M6uQlogUiP2i
	zAkdfaH9SEriscplV/0yRd6b3KEK6sf2+JEa1OLmPMBGqS4TeDGYt+eNjq00f21b3sGXlf
	VuZRB9ZhX3zkPMvlhvtc7/MRXrIayOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710153290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qax2WgVEIe4KLArEJwT0DggITTN6Jz8gZ/p1hvzV2tI=;
	b=L81a4abeYUDXgrBDeKj2lGlB5v7m1I7EzIOk8E/tgc0xb81UJwxmQQGvqWulKnvIUYzJvW
	JhSrMgNIyGKlyNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31A2F13695;
	Mon, 11 Mar 2024 10:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CtzgCEre7mU0HQAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Mon, 11 Mar 2024 10:34:50 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 521d665d;
	Mon, 11 Mar 2024 10:34:49 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Theodore Ts'o" <tytso@mit.edu>,  Andreas Dilger
 <adilger.kernel@dilger.ca>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Amir
 Goldstein <amir73il@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-unionfs@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount
 parameters
In-Reply-To: <CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com>
	(Miklos Szeredi's message of "Mon, 11 Mar 2024 10:25:20 +0100")
References: <20240307160225.23841-1-lhenriques@suse.de>
	<20240307160225.23841-4-lhenriques@suse.de>
	<CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com>
Date: Mon, 11 Mar 2024 10:34:49 +0000
Message-ID: <87le6p6oqe.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TE1SX6Jd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=L81a4abe
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.56 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 FREEMAIL_CC(0.00)[mit.edu,dilger.ca,zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,vger.kernel.org];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.05)[60.05%]
X-Spam-Score: -1.56
X-Rspamd-Queue-Id: E53AB34B28
X-Spam-Flag: NO

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Thu, 7 Mar 2024 at 19:17, Luis Henriques <lhenriques@suse.de> wrote:
>>
>> This patch fixes the usage of mount parameters that are defined as strin=
gs
>> but which can be empty.  Currently, only 'lowerdir' parameter is in this
>> situation for overlayfs.  But since userspace can pass it in as 'flag'
>> type (when it doesn't have a value), the parsing will fail because a
>> 'string' type is assumed.
>
> I don't really get why allowing a flag value instead of an empty
> string value is fixing anything.
>
> It just makes the API more liberal, but for what gain?

The point is that userspace may be passing this parameter as a flag and
not as a string.  I came across this issue with ext4, by doing something
as simple as:

    mount -t ext4 -o usrjquota=3D /dev/sda1 /mnt/

(actually, the trigger was fstest ext4/053)

The above mount should succeed.  But it fails because 'usrjquota' is set
to a 'flag' type, not 'string'.

Note that I couldn't find a way to reproduce the same issue in overlayfs
with this 'lowerdir' parameter.  But looking at the code the issue is
similar.

Cheers,
--=20
Lu=C3=ADs


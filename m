Return-Path: <linux-fsdevel+bounces-13197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95FE86CF74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 17:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69296B28F04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC9A36AF9;
	Thu, 29 Feb 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eXtJ+IqM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L11vjaZV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eXtJ+IqM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L11vjaZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E9160651;
	Thu, 29 Feb 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224218; cv=none; b=LDrZSKp40jj6f+2+8uNX7eVr5fP47J+0pgl1FOqJ3QNE+y0kltHQZWuCaYNM2b1cRJyyY+mPJLkPf2Qmj+al+RlKEmZl0Dn8llvtOb1/+ElxNayGp5l9ZZWm4+BS+RhvL5KnnBq9A5+zU5mjmtWLAE68ga6oA3yxw6uov37U71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224218; c=relaxed/simple;
	bh=7lVefdRKuQZZ/rmSHRQj+gMhsbmZ1UvSbxylCoYLCSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4zKup+hqHVZgajTUXYHkX/+7WpswdE5pjG77Web0B9OG7CtpCGwx8+jDqzXuKftBBq2j7FUgO6FkW8uxL0ao4wHj1bnGIY2HwNiopXYfJaawf1MjjNtxua2qHClBi8ixX9NST0dxAE/vyQHe1pAjS9gQ6eGhEDxF6YPOwh9Pzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eXtJ+IqM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L11vjaZV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eXtJ+IqM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L11vjaZV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B4CA21F8F;
	Thu, 29 Feb 2024 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709224215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f97jQf9rT96/WVP8/erEc6CgFevFY/2Sd34ERaaDVsE=;
	b=eXtJ+IqMp7YMYyfCsO2aN9wVkwyYE10+k0stGA5ny66SmwGchxX0UtN1YNXxwsEwYb/3VQ
	X333D26DNRJgr13plJo6TflVfS2+sYb/wFm7Wd01qYpwW2wMu4UAu7zwag5b4oP3sxxygI
	jqHtZeTKAo4AOOm0OV4YDivsV9oGPpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709224215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f97jQf9rT96/WVP8/erEc6CgFevFY/2Sd34ERaaDVsE=;
	b=L11vjaZVoANBzf2ktWepEddJbYkOJQpYJ1LzOBqZXle9IhZfA8OkS90ctDxvmcL8EX3f0f
	PZANm5iBGquwVyBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709224215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f97jQf9rT96/WVP8/erEc6CgFevFY/2Sd34ERaaDVsE=;
	b=eXtJ+IqMp7YMYyfCsO2aN9wVkwyYE10+k0stGA5ny66SmwGchxX0UtN1YNXxwsEwYb/3VQ
	X333D26DNRJgr13plJo6TflVfS2+sYb/wFm7Wd01qYpwW2wMu4UAu7zwag5b4oP3sxxygI
	jqHtZeTKAo4AOOm0OV4YDivsV9oGPpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709224215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f97jQf9rT96/WVP8/erEc6CgFevFY/2Sd34ERaaDVsE=;
	b=L11vjaZVoANBzf2ktWepEddJbYkOJQpYJ1LzOBqZXle9IhZfA8OkS90ctDxvmcL8EX3f0f
	PZANm5iBGquwVyBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3ED9C13A4B;
	Thu, 29 Feb 2024 16:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fwwgDBax4GU0PwAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Thu, 29 Feb 2024 16:30:14 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id c276250a;
	Thu, 29 Feb 2024 16:30:13 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <lhenriques@suse.de>
Subject: [PATCH 0/3] fs_parser: handle parameters that can be empty and don't have a value
Date: Thu, 29 Feb 2024 16:30:07 +0000
Message-ID: <20240229163011.16248-1-lhenriques@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[mit.edu,dilger.ca,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 BAYES_HAM(-0.00)[35.51%]
X-Spam-Flag: NO

While investigating an ext4/053 fstest failure, I realised that when the
flag 'fs_param_can_be_empty' is set in a parameter and it's value is NULL
that parameter isn't being handled as a 'flag' type.  Even if it's type is
set to 'fs_value_is_flag'.  The first patch in this series changes this
behaviour.

Unfortunately, the two filesystems that use this flag (ext4 and overlayfs)
aren't prepared to have the parameter value set to NULL.  Patches #2 and #3
fix this.

Luis Henriques (3):
  fs_parser: handle parameters that can be empty and don't have a value
  ext4: fix mount parameters check for empty values
  overlay: fix mount parameters check for empty values

 fs/ext4/super.c       | 4 ++--
 fs/fs_parser.c        | 3 ++-
 fs/overlayfs/params.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)



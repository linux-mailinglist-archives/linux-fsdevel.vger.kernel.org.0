Return-Path: <linux-fsdevel+bounces-13905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04F78754E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 18:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887681F2360B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 17:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4021E130AD5;
	Thu,  7 Mar 2024 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0VDieRCE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KmbEfxau";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0VDieRCE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KmbEfxau"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF012DDBE;
	Thu,  7 Mar 2024 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831438; cv=none; b=OsCTNYx8sEZK42zBfV+JuBmOQbdJUk4uQL/iNjo/Km3+CU/Q2l3b9h61hatHoAe74Y8Uuh+k2RgSXBItXpxSO8slZeyb7WJgUwcKGtMN2LKD8UoCdrcwzrfkP51Nl5X61zEoZyXPcLK4TaMKQOc1mcv3rdvydOhJluxBUmQM2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831438; c=relaxed/simple;
	bh=ePRxzCU8k8EGnokZBB4+4ln+F7jpIw9Pac4V0NZBhg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eugG1rpA4GUOu2FVG6dL/jklqMz+rcoVq85qjNeM5n5aVs/l1fG6VxNP7rvHXVPK5bIpCkCFy8BY3doUaExCssdzyFqV12QoWu8c1gapE83RLPggNChqmHFHC4at/722InQAE4BsP6z5CknfcGJweZ1YOeOxqoEz2Sz2w592NCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0VDieRCE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KmbEfxau; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0VDieRCE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KmbEfxau; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A4AB45C6DB;
	Thu,  7 Mar 2024 16:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709827351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjrVxieXuRhTZiWnKCpH9d/jIcN0kC0d2yC48QLOibA=;
	b=0VDieRCEz8N+eqziEuOrjkmp9rwnlUU6RmpL8KKW9YTtMiK4Pet04wWoVV/M9JWLdHf7/F
	5YDfyx4RrhAjsaygNRf43qQzl0ZY7Ss7ueyPa8s5F+Big6p+BewIHJHDJb7ftcML9TeWO5
	l6fcfT/OSoLdmEXNm8xbiMcUyFI9C3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709827351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjrVxieXuRhTZiWnKCpH9d/jIcN0kC0d2yC48QLOibA=;
	b=KmbEfxauWpnJYO0HstETm2VVp1i90gxDf8EetM7+IV5rNErjCxflVV6iWl0+6bTCLQjt32
	OwHm1cEBa2y8LkDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709827351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjrVxieXuRhTZiWnKCpH9d/jIcN0kC0d2yC48QLOibA=;
	b=0VDieRCEz8N+eqziEuOrjkmp9rwnlUU6RmpL8KKW9YTtMiK4Pet04wWoVV/M9JWLdHf7/F
	5YDfyx4RrhAjsaygNRf43qQzl0ZY7Ss7ueyPa8s5F+Big6p+BewIHJHDJb7ftcML9TeWO5
	l6fcfT/OSoLdmEXNm8xbiMcUyFI9C3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709827351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjrVxieXuRhTZiWnKCpH9d/jIcN0kC0d2yC48QLOibA=;
	b=KmbEfxauWpnJYO0HstETm2VVp1i90gxDf8EetM7+IV5rNErjCxflVV6iWl0+6bTCLQjt32
	OwHm1cEBa2y8LkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6B3A136CB;
	Thu,  7 Mar 2024 16:02:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aG4gMRbl6WXtcwAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Thu, 07 Mar 2024 16:02:30 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 48155153;
	Thu, 7 Mar 2024 16:02:29 +0000 (UTC)
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
Subject: [PATCH v2 1/3] fs_parser: add helper to define parameters with string and flag types
Date: Thu,  7 Mar 2024 16:02:23 +0000
Message-ID: <20240307160225.23841-2-lhenriques@suse.de>
In-Reply-To: <20240307160225.23841-1-lhenriques@suse.de>
References: <20240307160225.23841-1-lhenriques@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[mit.edu,dilger.ca,zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 BAYES_HAM(-0.00)[27.00%]
X-Spam-Flag: NO

Add a new helper macro that defines two new parameters, both with the same
name, but one of type 'string' and another of type 'flag'.  The 'string'
parameter may also be empty (i.e. without value).  In practice this helper
allows a filesystem to easily define a parameter that can be empty (flag)
or have a value (string).

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
 include/linux/fs_parser.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 01542c4b87a2..f582fb7bdc22 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -131,5 +131,13 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_bdev(NAME, OPT)	__fsparam(fs_param_is_blockdev, NAME, OPT, 0, NULL)
 #define fsparam_path(NAME, OPT)	__fsparam(fs_param_is_path, NAME, OPT, 0, NULL)
 #define fsparam_fd(NAME, OPT)	__fsparam(fs_param_is_fd, NAME, OPT, 0, NULL)
+/*
+ * Define two parameters with the same name, with types string and flag.  The
+ * string parameter can be empty, and thus it effectively allows the parameter
+ * to have a value or to be empty.
+ */
+#define fsparam_string_or_flag(NAME, OPT)				\
+	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL), \
+	fsparam_flag(NAME, OPT)
 
 #endif /* _LINUX_FS_PARSER_H */


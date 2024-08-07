Return-Path: <linux-fsdevel+bounces-25335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0649E94AFB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5CF283195
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BE814262C;
	Wed,  7 Aug 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sx25GZn7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e4+djhug";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sXy+4vJ+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LkgZH762"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F6E13FD69
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055409; cv=none; b=DIRD97PsaDFrHtuhzCLIsrNa8CB+yVReLsKcSEghtMsdnk02QUnVxEd+8+plld0dgAHS4qRSx31c9s+vGPsUElZImCwoejThnTPKvKlR1tiMEXhagEEivSsJ9nrfWndgPHpjK4DGLJtk1bTkICdZLwM79TQYYe91RramwCeUrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055409; c=relaxed/simple;
	bh=N98M1XsB+Und9qXMppAnNpzix96Pa6iHHZJLfQN7xKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MEmYSQuPWq3Q0Bj06yJVyCu6+GVe2onYrTQrZpgBrRWNXx+mGgaVX+sKBDKp7QK1Y3Uf2Cq+Jn7+E4T4Kpev3rebXHFdYNKas3gMU3vFzrc1pYbSgwCZqIjEsTVGp9/SmFxunVFeCaVhSMaD/yMeM2pRPHhtqGXu/qrrKPKSMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sx25GZn7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e4+djhug; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sXy+4vJ+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LkgZH762; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 09E291FB97;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=154BlcW3YZ3nsMEZMlq2IHbotwmLIvFT8sWAR+NBSYY=;
	b=Sx25GZn7bP0wuaCOh7f5G6Z1w3P9c2NW0GfpppyesxOnOBIRgs2+999B3B5ewz+JaOZob/
	ntK8ViWLJ5KWh/LL7xHJQQyqYQOml6sYu5TBfkuiucMbymokYywlSjgrRJELH6HiwxllaG
	sw8j4ftER/Dlwa2B0+k90RuGfLMM6o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=154BlcW3YZ3nsMEZMlq2IHbotwmLIvFT8sWAR+NBSYY=;
	b=e4+djhugirr72o9NnOBcVHO80PMzYMOsgeTdXZMxaBYRNERA7pdlsosgAyYco4/Y5RjhSB
	MvWAG4KbpEDuMwDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sXy+4vJ+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LkgZH762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=154BlcW3YZ3nsMEZMlq2IHbotwmLIvFT8sWAR+NBSYY=;
	b=sXy+4vJ+1Wu2oodZ4ltSzvtGQIC/sQAQybzi3vuWKcHVGCr4c/jULUX/uEQkGL/uJkgZtP
	ZdT6p6wl0xxq/qBYNzJNuEUje0NN2byZaE5AWMPcop7eVZUoHffodfhwsgnOcdLF8mvz4G
	XFEe8oEjQrpEym0mGA+N7Iv6lt5Ik2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=154BlcW3YZ3nsMEZMlq2IHbotwmLIvFT8sWAR+NBSYY=;
	b=LkgZH762y5Vte/Ghp70gaemYkq4iATT7Z8/yVCfIBdUuI/nDAs9KfIFpW5MGqpj36kS++f
	iuGjIHfPTsoN8SDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE6EC13A7D;
	Wed,  7 Aug 2024 18:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jyfxOSu9s2ZdNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 18:30:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9157DA0762; Wed,  7 Aug 2024 20:30:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH RFC 0/13] fs: generic filesystem shutdown handling
Date: Wed,  7 Aug 2024 20:29:45 +0200
Message-Id: <20240807180706.30713-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=jack@suse.cz; h=from:subject:message-id; bh=N98M1XsB+Und9qXMppAnNpzix96Pa6iHHZJLfQN7xKk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBms70UJf3M9RmJENcvFVbspnZ0E4Mg6J0MZAYBg82t qijF2oqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrO9FAAKCRCcnaoHP2RA2W9BCA CIDVawFDpxRgGRPtHSEfSBWP23PZJ8HSlHHq8iKorMOqedLU6M1PedWeu2iokXaYE6MLc5yyTlEBpx Zjb29WXw+tXKkzwtCtxa9LviFfnSy0GAIFBXPujiMj3PBqaE+84V5Iz2jnS6xAtd4M6AMx4uSLbkjG wcMWybbrVr+DplxBN5Mc0hVEutvBamUicIA59c5J651bCVWtBqeQ3m+cC77Kfl5L0gaTlHNNqQ4jNV z/YKmNalQHJAgFvWmoheleSPwR3k3bvoHKA9xp27/DphtUF1FyB2GmwfBdVr3Osw7mLYVg+haNPS3H tYojeh8uaD91j9XUHWUwyCh+zJbEPw
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 09E291FB97
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hello,

this patch series implements generic handling of filesystem shutdown. The idea
is very simple: Have a superblock flag, which when set, will make VFS refuse
modifications to the filesystem. The patch series consists of several parts.
Patches 1-6 cleanup handling of SB_I_ flags which is currently messy (different
flags seem to have different locks protecting them although they are modified
by plain stores). Patches 7-12 gradually convert code to be able to handle
errors from sb_start_write() / sb_start_pagefault(). Patch 13 then shows how
filesystems can use this generic flag. Additionally, we could remove some
shutdown checks from within ext4 code and rely on checks in VFS but I didn't
want to complicate the series with ext4 specific things.

Also, as Dave suggested, we can lift *_IOC_{SHUTDOWN|GOINGDOWN} ioctl handling
to VFS (currently in 5 filesystems) and just call new ->shutdown op for
the filesystem abort handling itself. But that is kind of independent thing
and this series is long enough as is.

So what do people think?

								Honza


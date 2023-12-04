Return-Path: <linux-fsdevel+bounces-4713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D277F802A4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 03:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62042B20797
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DD979D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qJEX7QFy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b4MiNSEy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE51F2;
	Sun,  3 Dec 2023 17:41:13 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4F4021F1C;
	Mon,  4 Dec 2023 01:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701654071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J0kuBlqbuyFIRvAKQathyKzOzQns3OWEbdl8z6xK/1s=;
	b=qJEX7QFyhqYTjTJqQZ3IFXSdUiduhFUlZjDGAqqcpIMQPhJEWzJTvDchAHp7suJzRNgnxN
	5j7X2L6nv/uNFZJ+x/W/eTnprfcdDWLL0BdLxoJ2fynnysx5AKxxmaos7mGS6lP+AzckLo
	SUcwJCa3U6b3CCUJur3+x2tcVTQceu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701654071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J0kuBlqbuyFIRvAKQathyKzOzQns3OWEbdl8z6xK/1s=;
	b=b4MiNSEyuKP7gDTBiOFwRzIcvpdkQRYBe7zNIi322buS9X5KJCRwUCTwMuwvgZMSeurvjq
	LgNbTHh4lC2Pm8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 515681368D;
	Mon,  4 Dec 2023 01:41:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6whKNjAubWV6OAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Dec 2023 01:41:04 +0000
From: NeilBrown <neilb@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Oleg Nesterov <oleg@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/2 v2] Move all file-close work for nfsd into nfsd threads
Date: Mon,  4 Dec 2023 12:36:40 +1100
Message-ID: <20231204014042.6754-1-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.983];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

Hi,
  here is a revised version of my previous patch titled:
   [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.

  There are now two patches - one that changes core code to allow nfsd
  to handle its own __dput calls, and one to make various changes to
  nfsd.
 
  It would probably make sense for the first patch to land through the
  VFS tree, and the second to follow through the NFSD tree, maybe after the relevant rc1 ??

  Details of the problem and explanation of the solution are in the individual patches.
  Thanks for all the review and suggestions.

NeilBrown

 [PATCH 1/2] Allow a kthread to declare that it calls task_work_run()
 [PATCH 2/2] nfsd: Don't leave work of closing files to a work queue.


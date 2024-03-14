Return-Path: <linux-fsdevel+bounces-14402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA5187BF22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 15:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBE41C223CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716D370CB7;
	Thu, 14 Mar 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h76XgWmU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VJUlb3WV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h76XgWmU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VJUlb3WV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E31A38EB;
	Thu, 14 Mar 2024 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427275; cv=none; b=MOVW22AlfYWYwiZ8YfeC6PAxnVEfMv9hjNNNZDBOytGklCWamnVYO8D7CG5aPocI8m1v1IiqtYcWWpbjfhDz4ypgePtQ5tW/uswRQZZU45vvWuGT7kRh+WVvLe6soBNIwVKgY2z9KBbCFORjZSc6sKoVZyXxFGgq8K11RG+rJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427275; c=relaxed/simple;
	bh=ELF+f59TJxIixei3mfagGQm1K4qILIyFUQQgSq9dK7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bM1b7DCmElVWRszV/9xFyZbFHq4xyUrdJmhjmZMmfmzNAPP1GwSbpObji1sY3nUqfLRSyH95Sf5BAjEnV4mKsfmZPpwySCFJveSxZBDcxBmPQ6S8r0fki9RZRCEbo1NCKgJN24qGMpiBqTx4uum2D8tR7JEiaY4Ap0Q8rfYWtsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h76XgWmU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VJUlb3WV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h76XgWmU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VJUlb3WV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25C1621C9E;
	Thu, 14 Mar 2024 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710427272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wG9JWTLr5OXP9cpOv1POjmlWyamPW2vvqR6gpOJQVKc=;
	b=h76XgWmUuxD9NXfXtIABjc5MVcushaKkbp0RLa2pms+DJzgvB31t8KJVU0rWB/x5cxLsgL
	KABCxIEL4knvNdzp/A6HzmKl/D80cWe5XlqlyuoPvf4sWj2K74Yq7M6HSXDdrt7KmS2iCQ
	StrF15jx+2qnyO91mhz4PR2lY4kvC+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710427272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wG9JWTLr5OXP9cpOv1POjmlWyamPW2vvqR6gpOJQVKc=;
	b=VJUlb3WVZyBIo1LiKEClrxGqh+X6nWYh7RohFOX/imEfxp0zFRsZb6b43gJ0aph1QknH/0
	bSEU6/FVoLybigDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710427272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wG9JWTLr5OXP9cpOv1POjmlWyamPW2vvqR6gpOJQVKc=;
	b=h76XgWmUuxD9NXfXtIABjc5MVcushaKkbp0RLa2pms+DJzgvB31t8KJVU0rWB/x5cxLsgL
	KABCxIEL4knvNdzp/A6HzmKl/D80cWe5XlqlyuoPvf4sWj2K74Yq7M6HSXDdrt7KmS2iCQ
	StrF15jx+2qnyO91mhz4PR2lY4kvC+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710427272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wG9JWTLr5OXP9cpOv1POjmlWyamPW2vvqR6gpOJQVKc=;
	b=VJUlb3WVZyBIo1LiKEClrxGqh+X6nWYh7RohFOX/imEfxp0zFRsZb6b43gJ0aph1QknH/0
	bSEU6/FVoLybigDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D67551368B;
	Thu, 14 Mar 2024 14:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vqwTLocM82W+GgAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 14 Mar 2024 14:41:11 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  jaegeuk@kernel.org,  chao@kernel.org,
  linux-f2fs-devel@lists.sourceforge.net,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com,
  viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,  Gabriel
 Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v13 2/9] f2fs: Simplify the handling of cached
 insensitive names
In-Reply-To: <aaa4561e-fd23-4b21-8963-7ba4cc99eed3@collabora.com> (Eugen
	Hristev's message of "Thu, 14 Mar 2024 10:44:09 +0200")
Organization: SUSE
References: <20240305101608.67943-1-eugen.hristev@collabora.com>
	<20240305101608.67943-3-eugen.hristev@collabora.com>
	<87edcdk8li.fsf@mailhost.krisman.be>
	<aaa4561e-fd23-4b21-8963-7ba4cc99eed3@collabora.com>
Date: Thu, 14 Mar 2024 10:41:10 -0400
Message-ID: <8734sskha1.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=h76XgWmU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VJUlb3WV
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.63 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.995];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.12)[88.41%]
X-Spam-Score: -2.63
X-Rspamd-Queue-Id: 25C1621C9E
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

>> Please, make sure you actually stress test this patchset with fstests
>> against both f2fs and ext4 before sending each new version.
>
> I did run the xfstests, however, maybe I did not run the full suite, or maybe I am
> running it in a wrong way ?

No worries.  Did you manage to reproduce it?

> How are you running the kvm-xfstests with qemu ? Can you share your command
> arguments please ?

I don't use kvm-xfstests.  I run ./check directly:

export SCRATCH_DEV=/dev/loop1
export SCRATCH_MNT=$BASEMNT/scratch
export TEST_DEV=/dev/loop0
export TEST_DIR=$BASEMNT/test
export RESULT_BASE=${BASEMNT}/results
export REPORT_DIR=${BASEMNT}/report
export FSTYP=f2fs

mkfs.f2fs -f -C utf8 -O casefold ${TEST_DEV}

./check -g encrypt,quick

-- 
Gabriel Krisman Bertazi


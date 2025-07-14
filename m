Return-Path: <linux-fsdevel+bounces-54829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F124FB03B4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 11:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D78717AAC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3260C242930;
	Mon, 14 Jul 2025 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="P6KUVfql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF81E47A8;
	Mon, 14 Jul 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486570; cv=none; b=lONzpPNfIXFZx9mPNMfAwsKW4W07/3mhvkRDlZAPnwpb2Xi/YTdGjDv7GJln6Aq7S4oh0rn/VF0VEAOV4vFCZAtgqqrEbPaBNFNf7KBaogyP8777siPcA/7W6g4rIdmwPsQfklZN7nK5QXYHd+2/TaqWAZKIlO0Xdg2VV8HbZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486570; c=relaxed/simple;
	bh=fSQmqTmFXiJr35bumTDLx/6khX6zLKHvHySYlt9rJ/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0uaOxl9mbcWB9l3jg1pkD47m4AwYl6vMaIuV+hsIKnztKxdH2FAUok9HBMQLtScStAhMRs0gISjsi6GKtPe07E8UjkBFXEw0tNiGE+pZGPd+IrUcp9VW8l7k46TxJiRxB+28wSRLBJjiP2WAmmr/tXzZ1ZVEazKF+1A6oSaLy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=P6KUVfql; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B6B2840E01FD;
	Mon, 14 Jul 2025 09:49:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KFiAFINQwJ0H; Mon, 14 Jul 2025 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752486560; bh=u5N4pTc0wlCZb0vYn03d8qHPb6wSiN52lq5zu+DU4g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6KUVfqlDJpHL8iXfV0Zb8Zb8VVTaZqCLrbVPIOHc6mS7eNPKWJHRJQF/cKT0kh2P
	 rYd9LpHOKx8gXD6eIiydUO7tOTwzeWd290HvFVePOgZBbdkOGNCiWdfzeqf9T71CMU
	 +NHCX9LCQtuMsQ+csYIG7YBa39hJoxRfUZcTQM2fUEw7IBS57aFekVNeF6uLbHYcQQ
	 6xnqzcPVIGo6sqFy50hHMHy0AbnAVQe/Xvr5e8T3adTdjrDTQu2EhrUGlte0ptPJPD
	 liTHkTl7Rw3wXwp3DL7S/PgVZbLo0iehAaWmWV8hkk59FLT9kfGS+EXflqef11FBJY
	 nlHYIoTZS1y0dGOORy+c2KMMcBFNxZemsnjHh33CL7eRDj7eT1OMerBtq4uzaLUbgL
	 kQXXAFJt4lDgBGTxmo6PBYWzoQjLKwdJ7ESJjX5LmUliipPFv5bC4qLEWrKlcEoXGb
	 UQksxvwe2sw6bOVlC5Eh0EeO3ip0VqOfkKlD4DG1IUEvlUIKw2uiVTvoCBCGL4BnNI
	 H/q5YDErGMlg76r4KA6G5srs+IOdKUr/nvUwX3kVUQKljaoZurHz7payTElBRJYz1v
	 EmD+uwPBLg604CGalyObU3zogXYOAwT+qw3CoQpU3evEFeEYdw+xsOtkNUz0P7VzrM
	 Xslq/7/PVoUAiHXRNy+oybGs=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A1B3940E00CE;
	Mon, 14 Jul 2025 09:49:10 +0000 (UTC)
Date: Mon, 14 Jul 2025 11:49:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	"David S. Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/Kconfig: Enable HUGETLBFS only if
 ARCH_SUPPORTS_HUGETLBFS
Message-ID: <20250714094909.GBaHTSlW8nkuINON9p@fat_crate.local>
References: <20250711102934.2399533-1-anshuman.khandual@arm.com>
 <20250712161549.499ec62de664904bd86ffa90@linux-foundation.org>
 <f86c9ec6-d82d-4d0c-80b2-504f7c6da22e@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f86c9ec6-d82d-4d0c-80b2-504f7c6da22e@arm.com>

On Mon, Jul 14, 2025 at 08:05:31AM +0530, Anshuman Khandual wrote:
> The original first commit had added 'BROKEN', although currently there
> are no explanations about it in the tree.

commit c0dde7404aff064bff46ae1d5f1584d38e30c3bf
Author: Linus Torvalds <torvalds@home.osdl.org>
Date:   Sun Aug 17 21:23:57 2003 -0700

    Add CONFIG_BROKEN (default 'n') to hide known-broken drivers.

diff --git a/init/Kconfig b/init/Kconfig
index 0d1629e23398..5c012aeb2a8f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -32,6 +32,17 @@ config EXPERIMENTAL
 	  you say Y here, you will be offered the choice of using features or
 	  drivers that are currently considered to be in the alpha-test phase.
 
+config BROKEN
+	bool "Prompt for old and known-broken drivers"
+	depends on EXPERIMENTAL
+	default n
+	help
+	  This option allows you to choose whether you want to try to
+	  compile (and fix) old drivers that haven't been updated to
+	  new infrastructure.
+
+	  If unsure, say N.
+
 endmenu
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


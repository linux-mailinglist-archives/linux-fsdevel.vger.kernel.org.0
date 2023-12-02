Return-Path: <linux-fsdevel+bounces-4697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF76801F0D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 23:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC49B20A28
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5810224C0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HhHWXOEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32D0BD
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Dec 2023 13:34:33 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c206572eedso1445936a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Dec 2023 13:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552873; x=1702157673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLyDJvxTAas36YBBDf/PjaQIfAeNkr7hpF36GzNdMaw=;
        b=HhHWXOEgmkx+Lle4PbqTWAgE0KdG45JToNHkLdsGrjdGZqNbxqw8kJrHygouAcqV+d
         owZ53Q5cVNkeHjlamz2xSsLdmrm4Dtg/GD9KPs8fVl/ZoW+uWRmfVtqde8T4aanFdzhp
         FQBhZJxkxPT/I7q2DI/ix+HmsiigJ4epjSp+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552873; x=1702157673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLyDJvxTAas36YBBDf/PjaQIfAeNkr7hpF36GzNdMaw=;
        b=YBc4jp4oxIQ3PcFmzoE2DnCWQtggHMYn0Rj45hX4JA8KJCyQcH4JKDXNdb7jMVV6VK
         PGsLRYAVyub6jdKYXHKPLUS8VxBH/Po4VsYziYO9++4aqS+5QphmeOyMXsGU5ElUlLlc
         5NqhukTlnAjrhhfrqMAmZd5JDUm9z22mS7RRhizxboL/3MrJGrScgvfOI/muhWFrD34Z
         XVBdH9AXNuRirHqQAzGzTC5a+BUooQsDUka6fudSbLRdhYIi6INXtr2onbm+uEkZIyB9
         YVB7muAjS9dRYWMgbgQEfxlZGyFg6y/k+mnky4X9jpq3GwMzQDw2M0OqobF6FzxTLZ2a
         86Wg==
X-Gm-Message-State: AOJu0Yw38VhSnM+8PVfkuJDSxchHqv3k7Sm/WKfkuf0KZaSiSch8Fg4y
	L1E6LV/Cyry5JNfXsoy8HS0Yag==
X-Google-Smtp-Source: AGHT+IH97qo71rxWkVbqooHXWm3am4MyA5QABdbmX40pWHK3KuNMNSgUPUEc1HYAA1B9MAWZgdr71Q==
X-Received: by 2002:a17:902:720a:b0:1d0:6ffd:e2ef with SMTP id ba10-20020a170902720a00b001d06ffde2efmr1311703plb.137.1701552873337;
        Sat, 02 Dec 2023 13:34:33 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902aa8900b001cfc50e5ae9sm5626968plr.78.2023.12.02.13.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:34:32 -0800 (PST)
Date: Sat, 2 Dec 2023 13:34:32 -0800
From: Kees Cook <keescook@chromium.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: Add DEFINE_FREE for struct inode
Message-ID: <202312021331.D2DFBF153@keescook>
References: <20231202211535.work.571-kees@kernel.org>
 <20231202212217.243710-3-keescook@chromium.org>
 <20231202212846.GQ38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202212846.GQ38156@ZenIV>

On Sat, Dec 02, 2023 at 09:28:46PM +0000, Al Viro wrote:
> On Sat, Dec 02, 2023 at 01:22:13PM -0800, Kees Cook wrote:
> > Allow __free(iput) markings for easier cleanup on inode allocations.
> 
> NAK.  That's a bloody awful idea for that particular data type, since
> 	1) ERR_PTR(...) is not uncommon and passing it to iput() is a bug.

Ah, sounds like instead of "if (_T)", you'd rather see
"if (!IS_ERR_OR_NULL(_T))" ?

> 	2) the common pattern is to have reference-consuming primitives,
> with failure exits normally *not* having to do iput() at all.

This I'm not following. If I make a call to "new_inode(sb)" that I end
up not using, I need to call "iput()" in it...

How should this patch be written to avoid the iput() on failure?
https://lore.kernel.org/all/20231202212217.243710-4-keescook@chromium.org/

-Kees

-- 
Kees Cook


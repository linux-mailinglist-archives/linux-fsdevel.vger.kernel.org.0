Return-Path: <linux-fsdevel+bounces-68267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC72C57AE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C83CC4E7BA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182631DDC0B;
	Thu, 13 Nov 2025 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NQXBE3Gy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BDD1DB122
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040701; cv=none; b=SdIDL4C3p5s/JfWReui3zuYQ7kgNVU1H0+sKgGhlzcJFPN9lS4KSocHZB60/P1jTS7Uof2agB8wuJ/BqkrgBXjSZbY3nwgcSr/TE4vopxSe++wNgTCf91C5A4zGwvdjbHw3hv9SyZVb0nJ/DxdEgWPnkQBVsiFGnkSsp5opDBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040701; c=relaxed/simple;
	bh=Ax3Y9gX1ZUmbL/q+/mzj3MbH2+MCJsINuDamRAt4zMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7TFbdkTpu/AlJMLjTi8kMjZfuOKcITklmAqzCHqusFrkWboeftn7ZSasD7APiHR3iLna+E+rI0bp6fvBmz/9QgH9a2WfmOYNS2kR5NjfTOa47fHuLOVeH1jFsRic0BwHZkMCdfNosc/+f82EYpGbWNuLaJAWE74RwyG4PS3W6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NQXBE3Gy; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b25e273a8dso93531585a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 05:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763040699; x=1763645499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ax3Y9gX1ZUmbL/q+/mzj3MbH2+MCJsINuDamRAt4zMc=;
        b=NQXBE3GyjbeYG+FB+5iEXaf/C2FpVRQuRGEiAmTFqJGsJ6C3uspZb8znaV/gMlG9m5
         4Qedtj748xlH/OjqdgT41rfzQdqrW3oleNOBFngm4/BOmZ9JAFqL7Z6XEw8QurCL83GV
         AxZbAcdfURYSN/juYDFCdsP7R9/4wAbiI6fEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040699; x=1763645499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ax3Y9gX1ZUmbL/q+/mzj3MbH2+MCJsINuDamRAt4zMc=;
        b=TMupevIU3jW6SHyXtZ0KD+gBbeswxLT4ITsQ8dutj67/NK3Bn9ajJDvnwdo3rs9bvX
         QigTzdycSecnnVHKBJaUVnRd/tCCvzz9FoxSFHBlEnfZXP78FqfVPR23bDeA4l5roAFJ
         DQ9N06v3KkdSBqifygEhA7jgnl1RGqjv8HfuyvwURDapA2O5Yi787HgWXLLaZ5cSOYHM
         1QK5jaBTySfHYyTBejMW8Psd5RCvWCD2OJCRrUWLSbfZCEwHLBttr4UIvCpKhVSTLLfj
         hXzA4wdVPc2ZPemN+MMoOTjn8kwCXQobFTfqriRR3XoDEomfWUFlKaDFiNbEJSi3n2qB
         yQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWqEaaMImLTAAMR2jjeTVcFsVczcZ8sFFLu+IIoSwdgk5JtIrFbDgzRVl+mCVszCppBq207O2jrICQuN3Q@vger.kernel.org
X-Gm-Message-State: AOJu0YydzqGgeGxHniLvujBqjddK513CLEQVZDITUyiKaDvCVhPnQNFZ
	+gq8WEx9PC2U8EC65gAMxXT0+cmsAvd9hicPoNwIcYAIg4TLmBsolFrXrWWihk4vrcVfvsuehtx
	FoPE8qu/n4Xf0IHVHTHtcWSTKKqRNIKcdELxRbcVa6w==
X-Gm-Gg: ASbGnctiaj97Fp2xhbC7ucHTDB3g3geUSdOAR/nnLef6NBHz5IWPmv16reqPJGSP7D2
	QZf/aXzc739hbyhzlQYE9xoBQe05TZPZPkaWfWXQPJ4pz+yNKmuK8I23ICTFL56gTFnjt3Zoe/8
	g81kuH3xI+O3luAWmEl/x9fvTmrFbrZZ1mnJcm3uV0x9C4YDoWwpKEm3w+Pk0vrJZTy/PAYSU9N
	xwuBm4Ylu+Td0E4znl/+iTjsIFDllqUN26C2pnTcK0kvW79V4QhjucKAoQz
X-Google-Smtp-Source: AGHT+IE4l67LfIFUAoL6YMj4yvFrNq3hC+Odb67sFJq1MxiWP5V2TQHshdoS6oFGQ4ou5uOwv72kTlMOEbZ4Ve/bk7g=
X-Received: by 2002:ac8:5884:0:b0:4ed:6504:96ec with SMTP id
 d75a77b69052e-4eddbda900cmr87104421cf.54.1763040698916; Thu, 13 Nov 2025
 05:31:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org> <20251113-work-ovl-cred-guard-v1-3-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-3-fa9887f17061@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Nov 2025 14:31:27 +0100
X-Gm-Features: AWmQ_bmSbb3TqI3Bzf63PgWag3y9K5UzJmasfZ98WfjSXHrA36CooBlTamJElpA
Message-ID: <CAJfpegt9LQe_L=Ki0x6G+OMuNhzof3i4KAcGWGrDNDq3tBfMtA@mail.gmail.com>
Subject: Re: [PATCH RFC 03/42] ovl: port ovl_create_or_link() to cred guard
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Nov 2025 at 14:02, Christian Brauner <brauner@kernel.org> wrote:
>
> Use the scoped ovl cred guard.

Would it make sense to re-post the series with --ignore-space-change?

Otherwise it's basically impossible for a human to review patches
which mostly consist of indentation change.

Thanks,
Miklos


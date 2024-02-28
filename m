Return-Path: <linux-fsdevel+bounces-13071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C851186ACC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 12:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8338528499A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 11:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF6512C7E8;
	Wed, 28 Feb 2024 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="O81cikK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2A12C554
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118901; cv=none; b=j0p4LScdGc2eWL+MjepJqJoTmmQ7w4CVE9HTkVBMrn/weL4Kep8Y0YKy6hLX2GUVBksVE/e175O+tVa6kL1P/aiqr5ogzG9SS+FDDpD5r04roQfgFxJCvXl4+cfBzd1zF0pH1q3gCEMSf/9eQlhXFh73LXF4qXVOBjPvL6V396g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118901; c=relaxed/simple;
	bh=m17SZHX4+wEV/WWevWAGgkPyEC7OMwhGW0aU63mqpEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJpOP1wKILYqgnZ0c8xCPbaK0bVHVgLeHtRwjOmNO7T6B6MqtsCeG+8IANwX0hUKjQTQ34YwcNQdRwVH3qbg71vt0IiCGNh5oiP4IlH3CWDr0eomK88zLTslv49a9xB2vWWxv954SUqPhKkTtIXFoCdyy93XcQcEbenWCBa2xSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=O81cikK2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513143d3c40so1662495e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 03:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709118897; x=1709723697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m17SZHX4+wEV/WWevWAGgkPyEC7OMwhGW0aU63mqpEo=;
        b=O81cikK2dAQC0wt533gRj9Wc3DAjbyCc2eMxH5CKKVNYSswwg2+C/vLS01MqMkCqH7
         tcK0enkb91rUXqzkekYC37WVW/TLQgNyyBNzwKPfbqAJSrhRsU56W2G2pxxpPIXpzRxm
         mh5jhbiEY/T1IAqDKeT1fTC19qgHGQWifjdSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709118897; x=1709723697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m17SZHX4+wEV/WWevWAGgkPyEC7OMwhGW0aU63mqpEo=;
        b=XNULhRhm3G8wxcqleSo3dGjYSMSCEXP7/+gvXgZZBe9VxL03Z6aEqlulGKAAlW+Afh
         3GzAQRLHAFgdZHfOSRUZtsdDmgwjWienLN7RFJyj9j+x5kbJlv3SovzOfh4H8V+Zrjnh
         lHD3V1ZdZ7myZGc3LB8aXrBLVlizmv2WbNX8ruH9Q824nGmSF2N8YqaqLumddqDUub6F
         TTdePpV2KSzVgovMiqjzzVTxchbw2xdI6qEKJiIk6oxRzXDR4ZbLwi+4mt+hCzMckrXL
         twWng4qCMGIAjJZETdzLnXFVEYygYwj7mb2/OvwZhjFYekBYFk8TGr0UwNv8lVDI/ele
         O8xg==
X-Forwarded-Encrypted: i=1; AJvYcCW+IFwX3Qq/SLHZZGC08m7XHbmTNfgWXnX4F5ev1U926Ta3qAzVlnGwmwHWNRbCo6ML1di+gvAV1K/npGtsxgD/B67tnuedjuYrrk7jXw==
X-Gm-Message-State: AOJu0YxfwHdp9d1FXhcGLA6vX4KD7n8ZFsNxeolHQrey0Ygyt+SgG5HD
	eHiXQ/oi833V0h9z/0deY1B14gLn+skRGitDNuRjGK9a5XwVTmu14/51R+8nkbOO0VohHDPOQky
	RBqyua+TCWG0ccSzw9S+WwykPE/gnjT+GpFW0Gg==
X-Google-Smtp-Source: AGHT+IHUUgRaf6YXFbTC4+mNupZ9l+8g/lcCMAEV0FyOuN+Fw1bdaCj8hRHXUcoYAUPI8j6hxUhbO1OrrW27VyiL63I=
X-Received: by 2002:a05:6512:3f23:b0:512:9af5:d083 with SMTP id
 y35-20020a0565123f2300b005129af5d083mr8948297lfa.60.1709118897377; Wed, 28
 Feb 2024 03:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206142453.1906268-1-amir73il@gmail.com> <20240206142453.1906268-4-amir73il@gmail.com>
 <450d8b2d-c1d0-4d53-b998-74495e9eca3f@linux.alibaba.com> <CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Feb 2024 12:14:45 +0100
Message-ID: <CAJfpegu3_sUtTC1uCD7kFehJWTivkN_OjcQGsSAMkzEdub=XTw@mail.gmail.com>
Subject: Re: [PATCH v15 3/9] fuse: implement ioctls to manage backing files
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	linux-fsdevel@vger.kernel.org, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 12:08, Amir Goldstein <amir73il@gmail.com> wrote:

> I don't think so, because it will allow unprivileged user to exceed its
> nested rlimits and hide open files that are invisble to lsof.

How does io_uring deal with the similar problem of "fixed files"?

Thanks,
Miklos


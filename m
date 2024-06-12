Return-Path: <linux-fsdevel+bounces-21548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBEB9058E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 18:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED3A1C2158F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 16:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EB0181330;
	Wed, 12 Jun 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gzjFQbq2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611B111AD
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718210198; cv=none; b=ghbS/kiv+6UlgangQJ4y23wFLLOjSyHkB8D8NGsSXcJdN5Xy+vibYBpuj/H1cdlhe7vOcyP8HYcqVQv5Qy5Gl9LdfC9y0vkt7lfZpMETAgaBeRp5HS/p1wiHcW0P7VyQf6t/lT1YmH2i+em/Y3ROuzWpCM2d0NMP7SXU0l+hbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718210198; c=relaxed/simple;
	bh=2iqv4KUGMLTmw6kxKjOHn2QS4F5+h+1D24yCEBorKAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdKrmQBEzC/YhaA75YDeUU27XCpRmxT0nTK5P3KUrTm7kMX2c45QA8oJyURenFNUW4NXfipybQH1IQK3E82eW3o9tcwJyvmnandfKUauCoQ+sYmL3IYpk9TSnAAaeXUecyG98gImCYS+rRb8F08fDXlvnqcTONTEQIVSdYJ2ixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gzjFQbq2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f177b78dcso11800566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718210195; x=1718814995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hccUwL20mQRicn00b3VnvJTlcDxqj6GcSYKwI7k4pbw=;
        b=gzjFQbq2QbUAz1uVMLFc/SyzVl/tD+XtiFvyH3lgfIzL/DdKA2rTbNZ4+x3bKviPbv
         ybUA94uEd/DtBL512gOFHJ6QW1M40zFKOE4qU33na+53x1nHu/tA0n7AOHvelaJdAKkk
         vIxt4lZ9Tv/EvcBaz0wpg+uIKxRcqHMCM5FHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718210195; x=1718814995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hccUwL20mQRicn00b3VnvJTlcDxqj6GcSYKwI7k4pbw=;
        b=JyKQrOIrBSbOfcAOfT6JdLrkXsJfGelai9mPrM9DoGfFIlEQdeRECPh+2/yOQ8pmIM
         dgUDwN3R6usu/HfaOF/kG+UsgRtlX5fda/96tl+2t6vhwIDCqcG1EFOvpplGvrIDgZbO
         sbZ1VLIq825ewLq4ZA5IeuYr8JiSBTWyaVv6YIzEnMX6SWOGPXmQKHfgSSTWIpMod49s
         L+vVa11Idh7LE7h4/Ja3NJFFyojXRaGBvR3czADreePNlomY4n5502KUlDiXpDyJUkM8
         Blecl2MbjPJ9+hVQzsN31xqVBwuEEIxudH8wVUADhcwtqfwWx+RLSMcxO+H0XbfFphqX
         ekhg==
X-Forwarded-Encrypted: i=1; AJvYcCWg4Gz9wByZIFWah70HbmZtkPhGppp5aUR0R7V7YJwiE+4Ugialx14cxOX+3FLlvoDGWovPfJyag9PaC7Z5AMTk3VbhLoa4XvMiGqllag==
X-Gm-Message-State: AOJu0YxQy1Xtg26RyAFPdjK9766iJdUkdDbSk6pPLyER/7Jz/GrGLwPz
	ATcicNFZnR2EoM0OLPNm6ucFw919L9wBCE6kSngQvigOgFPX1aT8yzAGKbCy9di2aKjig22coxS
	tUYvVXA==
X-Google-Smtp-Source: AGHT+IHL6xT8rZqe5gNs5rN5M5RLQP6YQ0Oj/EFU03t4PfXxR881J8/c54U7r3caKuMPO1DTg9thHw==
X-Received: by 2002:a17:907:7da0:b0:a6f:23e5:c112 with SMTP id a640c23a62f3a-a6f47f9c51emr167965466b.43.1718210194378;
        Wed, 12 Jun 2024 09:36:34 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80728be9sm905104666b.199.2024.06.12.09.36.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:36:33 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f177b78dcso11791466b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 09:36:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDihvRGaDJLPPApuwR707b5PDh5+tRlOVz+7Lcl7Huqwq6zyewSI//7CmyxGANmm7DF2lBZgXY5MvNtDtoTLoGqKHTBIkzPs9095Lyzw==
X-Received: by 2002:a17:906:540a:b0:a6f:5165:fee7 with SMTP id
 a640c23a62f3a-a6f51660122mr30151366b.51.1718210192967; Wed, 12 Jun 2024
 09:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607015656.GX1629371@ZenIV> <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-11-viro@zeniv.linux.org.uk> <20240607-gelacht-enkel-06a7c9b31d4e@brauner>
 <20240607161043.GZ1629371@ZenIV> <20240607210814.GC1629371@ZenIV> <20240610024437.GA1464458@ZenIV>
In-Reply-To: <20240610024437.GA1464458@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Jun 2024 09:36:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgf4yN4gGsGQOTBR_xE0q-9fB04omufZk2gnBRZ0Ywbiw@mail.gmail.com>
Message-ID: <CAHk-=wgf4yN4gGsGQOTBR_xE0q-9fB04omufZk2gnBRZ0Ywbiw@mail.gmail.com>
Subject: Re: [RFC] potential UAF in kvm_spapr_tce_attach_iommu_group() (was
 Re: [PATCH 11/19] switch simple users of fdget() to CLASS(fd, ...))
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Paul Mackerras <paulus@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Jun 2024 at 19:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Unless I'm misreading that code (entirely possible), this fdput() shouldn't
> be done until we are done with stt.

Ack. That looks right to me.

If I follow it right, the lifetime of stt is tied to the lifetime of
the file (plus RCU), so doing fdput early and then dropping the RCU
lock means that stt may not be valid any more later.

Making it use the auto-release of a fd class sounds like a good fix,
but I don't know this code.

           Linus


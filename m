Return-Path: <linux-fsdevel+bounces-59701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 492A6B3C858
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 07:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911661B2845C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 05:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD3F221F24;
	Sat, 30 Aug 2025 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO7KurmL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EAD53363;
	Sat, 30 Aug 2025 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532501; cv=none; b=jyX0BojBZpwkrrH/7IK5fiWWDTrKLt3B1HlDlK63mKDiHS03XIIxhBTIiKDcFN2zw0OhfBnDWv9h6fLKtnhPEnWJ7EMm02Ep3QzKW3lKIUPZHWi+t+Q0bONH8Olvgv1S+SFpSRSQGIOtEk3vd18TYRpJWbOwqlSrVpmjyU8bhSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532501; c=relaxed/simple;
	bh=7DQQNSZvGs99iEO9nzGnuKEoa7IJyJZ8p6oWbEvKlyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INnzGr+OSpsbnUl0SABf/B6m3noF3Yrx3HtgpD1XJBOy1e/SYPcWOR9h32NwWCpuzqdMFTsurigOTRKSl0aULER+s7GDGBAYAGaa7uNSIAXHr5D/WXT4yC3yBBZlh6szy9Y87Zv727jb+eQNk1B+Z9HGFSi2GGsGU6zM1Whx+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO7KurmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CA2C4CEF6;
	Sat, 30 Aug 2025 05:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756532501;
	bh=7DQQNSZvGs99iEO9nzGnuKEoa7IJyJZ8p6oWbEvKlyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lO7KurmLbkhBAjovlpBk2L6iqSOJ7oc+Jcvxfwxr/eG59N9/vQ3WQiNVZR2ZuAyU3
	 XkPn7A9Bd595UFE6f9pkAiu0cO9fuwuW4ejA1dm0NdPckvAQu8uInSVeH6c6h8zOrf
	 VVbkSglMwxQ7IdRQnxUz9bllkLsxRQLgT0ck9nT4zUr1qVOcOHGzCbSADclyMulZ+K
	 rEQxVwJ/XEMjGTYKAqiFO40bprmic2n2V5dcBi+wZOTaiTBefmv8Bo+9+dSFHTM0RV
	 9HoZ3BQ/KHQqSKnu/FzB3FSj4av0bJvTHUs5YYedz4rjiLgyv4TppqvznT/R8FcY3r
	 HSEf9c64bv/uw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so6918661a12.1;
        Fri, 29 Aug 2025 22:41:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV17SWNeQ0Z9lcFbZK8LJqK+5IuP9erZ2PHARMbSXuy6IKuA0QzGdJjDzesBPw5hERLxlwXvS/PwFNmVY+N@vger.kernel.org, AJvYcCW1en0JSouVceJLQzDJfCw2G902Rq4FPz1LrrliyVE8SmBlPYeumSuarTcN773i1eY/ZoGRswmKBNksJWjj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy8ny795ek8fa5Kt2htAy4a0XJs4fPncAM0Wh5R8e7+TciVz/v
	g/viy67OQWGfJEsdkL6BSEX9dxlKDyaWdpB07lS+wq/Upj3I7fAOSsWtheIac+Vwhrs0M830O+e
	NbH5d0xrzVJU5yok6rVzoW3iqj+OFCf0=
X-Google-Smtp-Source: AGHT+IF8L9Qq2doUMIQPSdyQRPaTlCjT2dbeNFdQ0tjfnP75+cjaOORXQrJXFo1JwdD5xbXkUeTDn15eWt73frSUUIY=
X-Received: by 2002:a05:6402:210b:b0:61c:e612:db38 with SMTP id
 4fb4d7f45d1cf-61d2687f49amr978099a12.1.1756532499725; Fri, 29 Aug 2025
 22:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825133519.337291-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250825133519.337291-1-liaoyuanhong@vivo.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 30 Aug 2025 14:41:27 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-OnPiWbzWm7B_WQQUcHG16kbLokS2cbrr3z0HS+fQzDg@mail.gmail.com>
X-Gm-Features: Ac12FXwYSDwwrfTsnfdgbs8UlEKWzE4STdc9YcPEp8DYQ1UByljWCldDszVDh2s
Message-ID: <CAKYAXd-OnPiWbzWm7B_WQQUcHG16kbLokS2cbrr3z0HS+fQzDg@mail.gmail.com>
Subject: Re: [PATCH] exfat: Remove unnecessary parentheses
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	"open list:EXFAT FILE SYSTEM" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 10:35=E2=80=AFPM Liao Yuanhong <liaoyuanhong@vivo.c=
om> wrote:
>
> When using &, it's unnecessary to have parentheses afterward. Remove
> redundant parentheses to enhance readability.
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
Applied it to #dev.
Thanks!


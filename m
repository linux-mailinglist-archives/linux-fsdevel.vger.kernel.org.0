Return-Path: <linux-fsdevel+bounces-70483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6DCC9D24C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 23:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 779744E38F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 22:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521102FC011;
	Tue,  2 Dec 2025 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OrjLXzE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992902FB97B
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764713270; cv=none; b=hcGQvpu8USb/u2dTBoi6lscxVMVMRCg6tzcgnzOx3b0l34hW1zAhpuer0ivXsjK/gyTEvyLHEVdOFswdgLj/NH74GP7P3JSicVqcmTpLWPSk+Gq75QyiploSphYcT8klrroi0R0EXnOx4k670p1//C1v8kU3p0KYcDy+6syjjBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764713270; c=relaxed/simple;
	bh=Bgjm9Mp+CAAFADrBLEEumssRz/B+zBUWKnIEE6eseUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYunGFWwoSZZAiCu9KFaDEmQaUGdlhwHgDQQ/qSru8hfiWDpIz8wIHMjINrOuJ3WpOp8Wb1GDGqeomszk8ssJqXJFslWjpnVEhgsSpRwzdPG2hzMRmqrS8fwqoaJnJZe8djTCXXb5l/Z+IJlDtRgvvpGLLo0nc45yxF9kyQCVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OrjLXzE8; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso3602060a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 14:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764713267; x=1765318067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R+xUpa7tpcXlrKuK2TYMeoF7urpbvQwlpFTRmhMT/tQ=;
        b=OrjLXzE8J2XwOW0Tg/x5KSXrZIle1KEztyD8AHQUw8oR1GxEsCn9uLtg1hEvIi4/BB
         LXu3KEck8hbO2zLbv3NXinKRejP5i7DXmPjsPiY17D+9shB8zD8lfTZi03OK9d09YMlz
         5Wd/WiMxxsIbi0FD7F3Shl7/ryc15yapKilPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764713267; x=1765318067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+xUpa7tpcXlrKuK2TYMeoF7urpbvQwlpFTRmhMT/tQ=;
        b=f5Pqt+ggUZCMBVvPoF1VYFOpqiYN2I+ZwoLKIhDRJU0WDkMCwcXOoW+OvborKYPfhu
         nE4eO6rZO3Z5CTo2v1BRanxoE4pzA2dLfm4/l+Pljw9OU2Bp7sqTKBfbfc5ymsHP3qJK
         5t5SIJucFZQWcE9xoh8YQjhwZM+CDKSlxgkvsEn0X1IZQsAekSyESfAPXZs2MONFX+/a
         iPs4If/RzdJfyu8O2puHsFrOVQr7IrgFtYjUmDsezOwnHUq60r9sz6lLU/ulkscd0boe
         rKL3ZMlnRJSiMEo7qjKgqpITz+hYcoTIc4mXVa4xgG5uz4Ur5EEv9H7aa8/MJm7zLmhc
         o+eA==
X-Forwarded-Encrypted: i=1; AJvYcCVIxv/gqAQumt9Hc3a6UzQJNUSecJlC5oNfw5e0VyvcCKjro2Dx1/Sa9z7GxDD7nzWLkS25My9CJLVnagY2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/SxWK0KdOvHrdBmrhzunSPtyRMNQ4YjOcsnMJWH4yqU9Nvde
	ZRe9qD3N6NexZ5n8Eg1+cnaw283txEvUVC/+ZYLXcPrBfBPC2nlBZxcb4ndtcK5ceg8lJQjOa2a
	cSV+DFyk=
X-Gm-Gg: ASbGnct/hEiqq5/tjJ6N3DeW0wy2EgjHHSIO0QZl6ThCLdtGU1SNBc5QZee3JzO53zX
	Kf+fijoT/9K/+0ssGlHizhhKHCdvJLDSWGbCWysDKRnNcs5rt5Ss/VGGvGt10ZCUgurz/6fgzDa
	n4tiaSV6ebHXoPRHqVkVxkgnWxN4HrPPc3V87Y63Sn9IQjzs1UURuuINeWSwIHnk3YLRCgS8sMW
	0dTQY9NVHIFfntr14l5KcuqMhB+3KMyRiyLPvZURzJ9/JN0NzJTqfnjIisNDscWoQRSCq4BaN8v
	nIEqPCRdadFoBIQQrD2iVOPCwM5fJswouXFF3IhFu/G5CQtaYMklriY3WimEZQgNxCKUUQHIg51
	XtxksuTGzp3mebjhtRPl6kt+i1yC/I0v/4UUhkIAuD0fKnMRVnEx56xFfWnjXhzFZbhh7DL3svj
	RQ8737msjX/eAXYYRZ42LnaEe+vQVJqq9HeA0rJqICal32JTq0/QKPVoNySdUn
X-Google-Smtp-Source: AGHT+IFoUQ/nXYVLd0rKj3WZWeqeG7wtVhfdZYCSmz3Xiv3Sq50AiozL6MFL4hBWZxMi+ilm5KSNZw==
X-Received: by 2002:a05:6402:4403:b0:640:abd5:863d with SMTP id 4fb4d7f45d1cf-64554665499mr39723200a12.20.1764713266811;
        Tue, 02 Dec 2025 14:07:46 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510615c0sm16816933a12.30.2025.12.02.14.07.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 14:07:45 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso8840339a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 14:07:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUctjD8VyJh8un+me5cRNgPggxD0fHywz6PIWCumw6KfXdin90agecIRreW4jjPKq0YPGKGnidZN+lG2qaw@vger.kernel.org
X-Received: by 2002:a05:6402:280e:b0:643:129f:9d74 with SMTP id
 4fb4d7f45d1cf-64554320e9emr44585697a12.7.1764713261899; Tue, 02 Dec 2025
 14:07:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <33ab4aef-020e-49e7-8539-31bf78dac61a@huaweicloud.com> <CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com>
 <aSgut4QcBsbXDEo9@shell.armlinux.org.uk> <CAHk-=wh+cFLLi2x6u61pvL07phSyHPVBTo9Lac2uuqK4eRG_=w@mail.gmail.com>
 <aS7e9CbQXS27sGcd@shell.armlinux.org.uk>
In-Reply-To: <aS7e9CbQXS27sGcd@shell.armlinux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Dec 2025 14:07:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg4ZnsfpgXYL5qhjYDYo1Gnssz+VxnKZzHXMEmE7qrnQQ@mail.gmail.com>
X-Gm-Features: AWmQ_bndnZuSySd3c7NVIocYoeSzskkAStzH6Kc1-mQN9xQL8na8ufP2gzQ6Lfk
Message-ID: <CAHk-=wg4ZnsfpgXYL5qhjYDYo1Gnssz+VxnKZzHXMEmE7qrnQQ@mail.gmail.com>
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Zizhi Wo <wozizhi@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, jack@suse.com, brauner@kernel.org, hch@lst.de, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, yangerkun@huawei.com, 
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com, xieyuanbin1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Dec 2025 at 04:43, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> What I'm thinking is to address both of these by handling kernel space
> page faults (which will be permission or PTE-not-present) separately
> (not even build tested):

That patch looks sane to me.

But I also didn't build test it, just scanned it visually ;)

            Linus


Return-Path: <linux-fsdevel+bounces-1615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F388C7DC4EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 04:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F813B20D5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 03:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E395668;
	Tue, 31 Oct 2023 03:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QNGs8imC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B97524B
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 03:42:20 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984E5DA
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:42:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c3c8adb27so770270066b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698723734; x=1699328534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E2Ob+plhOA44ddqftKTuU+U1KwqHcLgVEWBguJbBUkY=;
        b=QNGs8imCK9ibE8W68twgbWK8u0P6RFFhak4Nfcqb/TSNTI/mEcPhf9nPu2pe31S0Rp
         gjMLbO73K7sh9JjgeI3YcdW/6YCawRZry1orj7vyQrTTOImEC7xwT+3UPQxtE+nwl/BR
         cBaihdLt8X7RW/rEab+7WfXVwxe/yl9Aqe858=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698723734; x=1699328534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2Ob+plhOA44ddqftKTuU+U1KwqHcLgVEWBguJbBUkY=;
        b=As+xmvCThdwvjt4opP3TIQXZvdQjwjmCojFi9uasSBpSUN2D0HoO+VmpW7qe1odxBl
         eghdm5FJjmtH+HaLJ0fmintP4epE/yfzRjAvuKYTU8uddtATuIf2m+mYS2dM30Sq31S7
         YMKBqZd7RMya3zf/Vh6dXM26ptt8ekeg1d/OJDzNm12ou2dkD32jNxI3iILsShZXxBYc
         7bXd0jf+imH/Mv9y20OLOp4EFr6/4Pp5RJrfqZYfqgVRBd+Yodgeamg+axeUx+itv2FQ
         trh+spIrDy23o7TRF4D/oBOtGb2mwJxpge0E0bZPZXEW5HZ+9YgiwDQYRxyfqNVGLAx4
         MAeQ==
X-Gm-Message-State: AOJu0YzWlAHXhm6NMdaM83S0zl5SpLAkey7FvDSB01K9OfOJgdG/yLM/
	Wj+TRlyhviGz+UqBk4u2iQO2hgpyEdVSNPDg3piLUCax
X-Google-Smtp-Source: AGHT+IEujV2NvXohGZKgLbR9uIi/qJRFxNDlS9VOFupkqF/V+dR8gHAUELNHDb9sCXTm2kTqHgaECQ==
X-Received: by 2002:a17:906:a198:b0:9d3:f436:6804 with SMTP id s24-20020a170906a19800b009d3f4366804mr2593142ejy.29.1698723733817;
        Mon, 30 Oct 2023 20:42:13 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090629cc00b0098ce63e36e9sm240070eje.16.2023.10.30.20.42.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 20:42:13 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9c773ac9b15so770505766b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:42:13 -0700 (PDT)
X-Received: by 2002:a17:907:934a:b0:9c7:4e5d:12c5 with SMTP id
 bv10-20020a170907934a00b009c74e5d12c5mr9475622ejc.61.1698723732824; Mon, 30
 Oct 2023 20:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030003759.GW800259@ZenIV> <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
 <67ded994-b001-4e9b-e2c9-530e201096d5@linux.alibaba.com> <CAHk-=whCga8BeQnJ3ZBh_Hfm9ctba_wpF444LpwRybVNMzO6Dw@mail.gmail.com>
 <20231031032625.GB1957730@ZenIV>
In-Reply-To: <20231031032625.GB1957730@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Oct 2023 17:41:55 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiYnp=F4basZu269_xuof1ycFsCPntNcEWsGbAkmq_Yxg@mail.gmail.com>
Message-ID: <CAHk-=wiYnp=F4basZu269_xuof1ycFsCPntNcEWsGbAkmq_Yxg@mail.gmail.com>
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Oct 2023 at 17:26, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, is there any reason for -128 for marking them dead?  Looks like
> -1 wouldn't be any worse...

It's *much* too long ago, but I have this dim memory of simply wanting
to make sure that "dead" was clearly separate from "underflow".

                  Linus


Return-Path: <linux-fsdevel+bounces-9199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B74683ECAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 11:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13DCB23B7F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 10:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D512200AE;
	Sat, 27 Jan 2024 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuKbOhMk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1921EB35;
	Sat, 27 Jan 2024 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706350247; cv=none; b=bmB1VqqzdhdadzPCFmK6VzXIKUFFsRjLL2NAjbKiPG2C7O4M5iIdxS1odcF5x1ZH8fYzT6uOu4ayoDw/L9uOTsIpMbZBg07NFEIbwbDKLbFzKoCqXX8gsOxiA+eDEBuX/bkPxAIHRJxImTO+GOxSVklaMS4yOg/+CpZlt37+rkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706350247; c=relaxed/simple;
	bh=jSza4nl5ABvCTIqTesQ4ouII2QMVazxvM4Gbtr4uVXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+VOsVNjZA+mBLmuNeCBTuNS8BcBvaUXnB8Q4egsviDe/VuBM4CHXPA/7KGc4CfUTW24tU5K3PGIPtd2XrXoR1tYglahaHjbakp9bEhGK4arob19LQi09Siv6IMGjvdsw2qcb93oCvk1FFqlIe1I3sgrL/w1S3iV1mlrMAPkTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuKbOhMk; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a8a3973c5so4072851cf.2;
        Sat, 27 Jan 2024 02:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706350244; x=1706955044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8boM7ORGYNMPVReZtTMFOzEa3BTzmrT4lpyXZ03SE4=;
        b=QuKbOhMkI2iwWdP+0on4/8AtWkbxBj0BxNuysnj7jsoUdxQLOHBsM0gSSa2mVYFexE
         EQkzN/zdeiO1orTw0fnCb26emWmkVzmqCnuT9YYafCOAU2uZL0uYaagmuYSQe+u9E7Ua
         dS+dKCNAULvPYJSBBmSx6OKObt/Akk4G3bgeXQsXhVohVmsbbiyWU9bLNG8aWHrj+q4F
         7XU8ZZKFqxe3L5SvEs1GKr8CHUOE97q12G8ZgnngmEq0NN+GHtwG6XvZtvi2COO49OKx
         efrhhqHAI1RDE3uRLRWVvXSGZASL9QZIf7lDcMcNSqbBKxYuhwsA9V6HjpP6yiLCY0bG
         JtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706350244; x=1706955044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8boM7ORGYNMPVReZtTMFOzEa3BTzmrT4lpyXZ03SE4=;
        b=t/FSKK66l9UyrILW+LDFNR7yv6BTniP7jqYrAAlzxaPr0ZbylhOQssk4OTHUDXyXMN
         xe4+61YzHE5nG/nXimR0iAm7Bxvk2seKQtkSmyPCkkMtH2O13rnBan7AlkATuoIZuCjp
         kku8A+mogR3ldICEYHvGSRrhlvAvSzD+IzaaRJIU4eB0j223GgRtJeHGoZOmjYmIQR2I
         5vkw3RzVHH45/5BIAIw7m5gIo6zvRjFCNGzH3Xyhuyi8t7TFFt0tV8YMG1VX+xrDJBCb
         jYotZIUdGz2bY9IuKxTWtFRFk6HrgOEQEuv6TvPfS3VWCvJOFLO8ijAD3VKUrsDH0hvB
         7LNw==
X-Gm-Message-State: AOJu0YzMLVrp5P8vg2C3D4L6bIX3xfr1bN/32JdddosLsqOz4cNRope6
	RffHHd1wakRXkZ7vZ1KDWOHAPZtMK3hrOanG3LWtKKpzzeAE07/jJbIcsGxUpp77mt28qF1PMOa
	da3U3rU55v5OyiX23R0Mk43YSFpXb817+guk=
X-Google-Smtp-Source: AGHT+IGUiH9HXC26Vu3/anzdVnuqtGlcGQJbaXMTzGJ5DFv7hsAeCFLU6XPgobuQw9kM3iclvcK7hFxD/N8fQjpWGJI=
X-Received: by 2002:a05:6214:258d:b0:681:9ae1:94f3 with SMTP id
 fq13-20020a056214258d00b006819ae194f3mr1669408qvb.115.1706350244304; Sat, 27
 Jan 2024 02:10:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
In-Reply-To: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 27 Jan 2024 12:10:32 +0200
Message-ID: <CAOQ4uxh1BCmBA3ow130p1FBUrLLRVO2i_DDtAGQWhAzrabmP8Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 6:24=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> It's probably worth doing another roundup of where we are on our journey
> to separating folios, slabs, pages, etc.  Something suitable for people
> who aren't MM experts, and don't care about the details of how page
> allocation works.  I can talk for hours about whatever people want to
> hear about but some ideas from me:
>
>  - Overview of how the conversion is going
>  - Convenience functions for filesystem writers
>  - What's next?
>  - What's the difference between &folio->page and page_folio(folio, 0)?
>  - What are we going to do about bio_vecs?
>  - How does all of this work with kmap()?
>
> I'm sure people would like to suggest other questions they have that
> aren't adequately answered already and might be of interest to a wider
> audience.
>

Matthew,

And everyone else who suggests LSF/MM/BPF topic.

Please do not forget to also fill out the Google form:

          https://forms.gle/TGCgBDH1x5pXiWFo7

So we have your attendance request with suggested topics in our spreadsheet=
.

Thanks,
Amir.


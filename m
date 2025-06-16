Return-Path: <linux-fsdevel+bounces-51795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BB5ADB913
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 20:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FE73A4B3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 18:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959EA289E04;
	Mon, 16 Jun 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxLFR8cQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A94021D585;
	Mon, 16 Jun 2025 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750099783; cv=none; b=uBOAGGfq6IsqCdIZXUII2GgpFAs4u1Dub+2xTYjnD3SKOePGsbrars+w2fCcAFiKXexoyWhQwdQmLSMunhM+NwwlBSE9A682VkHso7ic7KQARcOE7P79xK9HETzf1OzeUnbuXQvw4lg732snTdS6Y27sXNm6zZ2hsg07v6k3r+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750099783; c=relaxed/simple;
	bh=9qQ61Kp9umUHi4GxqExw5FJpuvThBeB78u+krMUOoCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bg5ahCRL+O2/2BNTQeuUdSZPaDhGF6fQV3hJSxvxQ3H9EYHEDNosdJgWE+VSIoyAi5OoOgK8Raxj0JHXRNls3eiJre0FEFnjxszDZvuUMB/Yi9NI33ONxfi+G8319c/C99qh943RZYcuTwzgaQzv9eHGCXb2b9dGmEZUO7mBdfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxLFR8cQ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a44b0ed780so71726051cf.3;
        Mon, 16 Jun 2025 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750099780; x=1750704580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbNgm74YKelcUXDbOCv5OUWQbQ2/2H3RfdKt5p5VlZA=;
        b=ZxLFR8cQwgmRsWpY0v6qB7JRsTNDSDVBDgwI4+Tsaf/WsDD/lbhFx0MYJfgsAaBXns
         LUDUMLXDveGI9eq1p5o+CiF9gVx0/g6kcyXcpBtMqtHFU4+ez1ya+TZEYibWoUMBAl00
         cJAvLD1Fb3ao/TzjkUTc7DHydIbh76vHm2GTMfLcHAqjmV1m+IzXWvudsBdtSvhlyaxD
         Dk2/5n5xoL7L09moRTN/cjbFdQ3x/gRJUmaMSLevAWZ4VeIxJ+gdFjHzjf6RPM1AaQyo
         bJmaN1B8r7p4AxMKKuxIcsf34VR8RNRSK0HwdlzZ5vp02KaKsAPN8KYrhJLlvaIHRISq
         haUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750099780; x=1750704580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbNgm74YKelcUXDbOCv5OUWQbQ2/2H3RfdKt5p5VlZA=;
        b=uG5wmybjO1DfQx042eNviRHscxAQb4rFklIvK73RPaVNTUOrTh6BAOVfHyGMHkCAfy
         D5GD7uQslvmy1GP6k2urtCOgaOyv5wHzSLGfavO4t4TxcoZ59RfniCM4JhI/tOqJT356
         Zzq3gAd3C2bfnXd4zRf6HBxeq5OQmL6FL1l7hWFl66Lt7im0BJPEnKHnqzMq4R91oYMO
         9OLEi1lTPAQsCgeH8GuO7x9TDssgx6AmYeZwSv/p77jXtJZpI6plgqx0xwI90lijVdoP
         hm1F3cTDp253B6SEyLIMGis6s1G6Sh5W820l88e6Y/TIPeZAEQvJQbtH9y99+SoE/qXO
         GtbA==
X-Forwarded-Encrypted: i=1; AJvYcCUNEJIJ9R88CpcpXRIxMOmF5LAvQruUqTcQqXT3OPsgALYRTPr0/nOgzTvDPWR5W3tRAbQnOD0dyjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1d7qrimwO4ybTAPaS49GZMRlJ0aJYOIbDxcKw5U6QI1rjzv1
	/BiQS0aGCuhPxJEo2qqkXwOrDan0EUUGYisK2pyQ4y2V6y1+elmdaTRXQIMgLpnhBVvC5p1FWwA
	XQMK/I6z1rJgV/fskHDCPQcfohRw9Jc+wIIsa
X-Gm-Gg: ASbGncsn9b42lPphTPEXgfi7ZDdX+gFxJgBoaNztB+IOvsV/ZGlNuNOK2Qv5iIGfCBW
	jaaGo7pos4zpCwdz8y2RpBozLYvyVggNHQvXrx1gwvGgekDLZwUUo2aNryEPknIFOovr71Z96ZF
	GBlvAG3ULZyDElPPWNgG/m0evbvkCgrlIMvawXBW+V0ijdJeQdlxpkzReUKo4=
X-Google-Smtp-Source: AGHT+IGLpiMCmBeTSbFoQsIrZlhUdYB0kqAULHCAu+w8Mgtog6QDPt8QCC8hl4dZyD8ugor7d/G7sgZ9V4+SDzgTRtQ=
X-Received: by 2002:ac8:58c8:0:b0:4a5:9b9c:2d9f with SMTP id
 d75a77b69052e-4a73c4fce3dmr182509771cf.2.1750099780359; Mon, 16 Jun 2025
 11:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
 <20250613214642.2903225-10-joannelkoong@gmail.com> <aFATg58omJ2405xC@infradead.org>
In-Reply-To: <aFATg58omJ2405xC@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Jun 2025 11:49:29 -0700
X-Gm-Features: AX0GCFvBUNWuSpPPwssnIdbnfMc4X1HhAR1N3Dkoa9SeH6VgFYK4K-hGJ-eEvmQ
Message-ID: <CAJnrk1a934dLVLjUo2hy1jTo4B6xcj4ODMRb_YO8aM7CfquUfg@mail.gmail.com>
Subject: Re: [PATCH v2 09/16] iomap: change 'count' to 'async_writeback'
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, djwong@kernel.org, anuj1072538@gmail.com, 
	miklos@szeredi.hu, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 5:52=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Jun 13, 2025 at 02:46:34PM -0700, Joanne Koong wrote:
> > Rename "count" to "async_writeback" to better reflect its function and
> > since it is used as a boolean, change its type from unsigned to bool.
>
> Not sure async_writeback is really the right name here, the way it is
> used is just that there is any writeback going on.  Which generally
> is asynchronous as otherwise performance would suck, but the important
> bit is that the responsibility for finishing the folio writeback shifted
> to the caller.

I like your name "wb_pending" a lot better.


Return-Path: <linux-fsdevel+bounces-29895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D78297F11A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 21:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7761C21AAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 19:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908B91A0723;
	Mon, 23 Sep 2024 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fSb0V6Z+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65511FBA
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118466; cv=none; b=n2mv/HSICcqQNL+14hpYTa30n7d8o1w+2z7+5WBtzt5En6Mu9CLPvs8+k/GI4SBXM6af12Zn+iXithB8iOk7zca0hc3RbO9JPptoGEdhul8ZNP1SM7mAPkmrVtDYl41PGvTnCBvq3HS7ku08qVqFlsjJbBnvL7mBNYwLwi7imdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118466; c=relaxed/simple;
	bh=6oA7gDJzUeZfHw/vFTOmEelPMtY95bHTlj5TQt3Oydc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxHDZG5hiQy2qEc1ESdY/gInRsAX9RA3jSQVlM1LIkTngRVCOgnux0RXE1Mg62uT2FfEGn2WfBrRzEgAOQR59mODt7bGN7qm1z7lzHlRR15aMStolZ2aalxDwKu/GhZIN5svCq6f38sLdPF646PYG+/t/xMEWFqNH+5m3Q6HM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fSb0V6Z+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f761461150so54899211fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727118462; x=1727723262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FdJ3u8jesj1qGHjIV/QOFO/xQy5KMIpe78wId6CJClM=;
        b=fSb0V6Z+5CAymzLG/YbVjfXGwdHMAE2Idf1I6NOz35i4H/2YgO/PBATDvIAmdqTBay
         v00+0l8I6SoO/4ZSx1vn/yOxsLw3HCpmw+97+RX3JmikAEnaUnMGN+tSS/ROca4NQueW
         0Kheq3rVM7M0fC6OXTQ3hHSHmwxNEl4WtxjzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727118462; x=1727723262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdJ3u8jesj1qGHjIV/QOFO/xQy5KMIpe78wId6CJClM=;
        b=pCfarCLC2nqvpmPuYMlZ5CRCa/T4y2XFQvWNqdS1HXRm3mBojbmHEepTSxa/MHDh1f
         BOt6FZ6berjlI+9Bhv8uGgdRulCPsKiyafUyBg7CTmmHQZQkWQ1hsU/8vUxs6/Rpbvhn
         LQ8guNJGEpjXSIIJZSgCkrGGUIE8sht/debfehS9xGb2QivTepWIKqV3aItibKMgYFcn
         qF3vLD823+4/Ft17ULx54SaHUmG1vV13Z/Z8R4GMgn3xA8UUvTtH9kB8C50lQvaMeDod
         eFAtBXYWrYd5/IotsjSFQOrGfU+grIwgbaC9H54j/j7PzVBUodH33elTSG8XqPI2nxYL
         W91A==
X-Forwarded-Encrypted: i=1; AJvYcCX3ewUDNAitvPu+Gvme/Yzw9Piebp8Ez8WVzd+8Zpg5mMQb0mrw2azkOytoCBf1DumGZ2HEH8IkA7vEQQoV@vger.kernel.org
X-Gm-Message-State: AOJu0YxYcEa3ciq/BXWn6IU1+UVtgFgFpz5U5oK7pUIrl8cWGAYes6z2
	ybR9gDCZh0ly+EVzTST7zlQwCeKcAncTrdRZ+FJB2j7U2RKbb6BK6uNbfBoLvcOBOUw6ZnMqyj8
	atT8=
X-Google-Smtp-Source: AGHT+IF5MdhGThTI2P6NH7hB745QrujNyhc+XvZMob4VXNvyr9NHLrZ9ZSkFGi/zb8IMTkHCbET7Jw==
X-Received: by 2002:a05:651c:1543:b0:2f7:c7f3:1d2e with SMTP id 38308e7fff4ca-2f7cb31c4e8mr76907481fa.19.1727118461781;
        Mon, 23 Sep 2024 12:07:41 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b7f14sm1265087066b.100.2024.09.23.12.07.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 12:07:41 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c3400367so4183600f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 12:07:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSgNVOoHk+1joC+cmBL/GHUt8aAc0W5bQ2DyARoTfPqyOJ+YSZVUKUpuU4yP8e6HO1yffk18E/03LGWJRZ@vger.kernel.org
X-Received: by 2002:a5d:5e0d:0:b0:37a:4713:3de5 with SMTP id
 ffacd0b85a97d-37a47133f2emr9049324f8f.26.1727118460522; Mon, 23 Sep 2024
 12:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm> <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
In-Reply-To: <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 12:07:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEDDexH4DQdmzQMipPPABVoHmXBx_byHkWC3qUM3uamw@mail.gmail.com>
Message-ID: <CAHk-=wjEDDexH4DQdmzQMipPPABVoHmXBx_byHkWC3qUM3uamw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 10:18, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 21 Sept 2024 at 12:28, Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > We're now using an rhashtable instead of the system inode hash table;
> > this is another significant performance improvement on multithreaded
> > metadata workloads, eliminating more lock contention.
>
> So I've pulled this, but I reacted to this issue - what is the load
> where the inode hash table is actually causing issues?

Oh, and I also only now noticed that a third of the commits are fairly
recent and from after the merge window even started.

Maybe there's a good reason for that, but it sure wasn't explained in
the pull request. Grr.

                 Linus


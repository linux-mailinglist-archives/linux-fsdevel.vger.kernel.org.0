Return-Path: <linux-fsdevel+bounces-58395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18942B2E12C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 17:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7945E680C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4E4262FC1;
	Wed, 20 Aug 2025 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JE3X2YB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA2B255F52
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703470; cv=none; b=NxDAYppovu/9T5tLSRnJYlMJrRI/nqoenhlGLHhoejAd4uh4Dk1Z436+55BbNlqZhG2nQVdcz8ciMyQYrcrTSZ1c3ItHgLOml715mfg3T/RYqCr6rvadPwevY/pp8kavdMZQyqf993jVUPpSUTUxH4QCwJ6kIsyxqAZQnJ6sY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703470; c=relaxed/simple;
	bh=DW8nUwEnJevAyy3TqXctJ6qaOAMRNuWQJB7hcCq6TJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWznpcwXbhIkT9AkcUBSB/H3cXCoX8/rN3ALUqElqAf/g0YKxtgA8jmADwXkjnxJjlrKrrKuryfDpnKzQEpALV0FXw2hCbay2F8fZ8abn1WhTAK5zav1TaWNRPFY5NPlQR0r9nKqyNjHOMzVD9bw+/mw9gl1IreQer0g8WfXh98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JE3X2YB2; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e864c4615aso111353485a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755703466; x=1756308266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xUrkTxRcfOSeOaDb2V72zeuNSU+pP7qo+BiNbeu6TBk=;
        b=JE3X2YB2JKT3/uWIE7DF8T2wMhuZnO8qa6n7LuD+g5HDNjgD6MeCIUCNwnWGCYGW9r
         k4C9ec+NqdVCrhXAA0Z58TmG4U5WFTggRBVaRm5J9C6Ra3e8cXiO4LE9TG2g+fQhu/NC
         7bjPHZCJyvv7/knsLX/OT4XeQ6NffSa1qVJak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703466; x=1756308266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUrkTxRcfOSeOaDb2V72zeuNSU+pP7qo+BiNbeu6TBk=;
        b=j/2EguSuKbBewSE7pMMP3i+AECGqsa4R/blC2YUew8i+4ECycaqH+KNfnogx1kkXKb
         LMIuuZvIj6kQXVYXjOSyt5UG7AdbwbY+pVZ91jen7PMV/HBdzlIolp07v7ShuiQTG/+O
         +5XjyrQNbrZPkCX3jlBzzFHzCrf1As5pQ8VppaSpdznpFSG8Yrbh1x/5P1mgZZEUe8vA
         Kb24BLVFZF9AQH0hDbpzsbNTbgOlu2nu+pRxbecGan/MC4aWPlmnxflf5WuQlgxpGzSS
         7mMhEVzxekHMi3xldFYv6tUDXsaTRR6Fd6hzDSa9Ag+LbpyImegBLGx3qhVX9kyHsN6o
         VrMg==
X-Gm-Message-State: AOJu0YyB+L/Z7r9GhiUZnWEAqx55PWzEhD/2OiUrYMES8047mlKRPGp5
	SDW4xembemb/6uLjWjwtzfmHZPAoULQdF0uenYo+magNnKowlckz3nGe1wGBwV78c4bs4VAdkQs
	Z4qJfuBK0/3RQ+nPwRI1c3ProoNpsEV4gykyV/L/FUJRUZaxeyVN0
X-Gm-Gg: ASbGncvRUO/TRMGxS+tyugtr8sswXcMBicrSfeu9EatW8CuOp9CLnJG+HHk7YJDlNNh
	mbBYHmZgZwwA7lkrJh2rHhlVN82i5U1UBp5F6PT3KzREppmZ8VNaxhky9c3zA+E1XkxV1CYylpI
	PZpdYKAJHRTBj7009M0kTyBBwEQP22LfJKTwhbHDf+ch+11LHF9drgsl/DzXlZ36DeMscP2G/sO
	wBmbXiK7DIaMxXnYmol
X-Google-Smtp-Source: AGHT+IHGb5uVSeCyfb53MZMI9z+edrnTeqn44F9HrnpUPoYLrqM+zf5ohfyT3IuxJ0FB9rVJOENY0kAlyPTtgOJvrg4=
X-Received: by 2002:a05:620a:458f:b0:7e8:a40:2cf9 with SMTP id
 af79cd13be357-7e9f460970amr701823385a.26.1755703420556; Wed, 20 Aug 2025
 08:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449542.710975.4026114067817403606.stgit@frogsfrogsfrogs>
 <CAJfpegvwGw_y1rXZtmMf_8xJ9S6D7OUeN7YK-RU5mSaOtMciqA@mail.gmail.com>
 <20250818200155.GA7942@frogsfrogsfrogs> <CAJfpegtC4Ry0FeZb_13DJuTWWezFuqR=B8s=Y7GogLLj-=k4Sg@mail.gmail.com>
 <20250819225127.GI7981@frogsfrogsfrogs> <CAJfpegt38osEYbDYUP64+qY5j_y9EZBeYFixHgc=TDn=2n7D4w@mail.gmail.com>
 <20250820150918.GK7981@frogsfrogsfrogs>
In-Reply-To: <20250820150918.GK7981@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 20 Aug 2025 17:23:27 +0200
X-Gm-Features: Ac12FXw5HMCd7kxL_XteSY648Ip54VC5kV-hPUL7a1lV9-R4ThoOtLf58kMZApc
Message-ID: <CAJfpegs6riQX+B43c7EgkRJBg01V_13yEyETj_qHRA2S0evNLQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net, 
	bernd@bsbernd.com, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 17:09, Darrick J. Wong <djwong@kernel.org> wrote:

> > "If neither forcing nor forbidding sync, then statx shall always
> > attempt to return attributes that are defined on that filesystem, but
> > may return stale values."
>
> Where is that written?  I'd like to read the rest of it to clear my
> head. :)

It's my summary of what you wrote as code.

Thanks,
Miklos


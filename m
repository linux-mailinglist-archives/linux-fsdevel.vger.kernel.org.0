Return-Path: <linux-fsdevel+bounces-59347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88865B37E4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 11:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863961896D1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 09:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5CC341672;
	Wed, 27 Aug 2025 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3UN3K0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6FF2F3C0E
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285483; cv=none; b=pJGv38HRPM+f7nrHGWK48/V0POccwW/lzUivYNbTLW+N9cHAFh98egHkE5QZrIUzKRDYrB92wL80f0AyqNspRx4Ss8lQi300JiXDV5xHDuhxX/elFd7KzPg16epJbZWOqytK8AqSf0kEb0XOKjMfelyHB1lwyM9Rp4bHYrEYc3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285483; c=relaxed/simple;
	bh=SD62VXtBOng68f/p5wJ2K9ULc+LBnnfK1DqiOyJ43OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQ42iAqmNYg59tEngZIsvLAxyEuzid0WUKQArKtn+gr9eu/Q30db7Jzh2jYh3PZ2QNkytPI9KreISoD+wHeWD1G4SmWXyzCyg5fbLaTac5qp88m9o+9uiSBEIN9hZdigkV/cqI4bUFiVnfIAPnFyZb91P+aoreGhlMml4UIfpSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3UN3K0L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756285480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fw8PyVzU9d4ukCHpPAAs24WjaVsKl7BVkmu/tQSiZdI=;
	b=Q3UN3K0LQiw50LuS7NK9IvtVEnLUkn7XSWoGKzZGARmjaVvLYgVEXOMd+6Jfp3SZ3uliU6
	6LHs5DOyD6Nb+C4AW6Gf/8uHIRQGo26Oei/+vJHLAdYMAPUumAqXzLsR+iwnCPEnNuH3oZ
	g0981haKaTNQVVpPWLA1dUP2ytpNrg0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-7u3lETN1N8a-yOR-Dkf0Lg-1; Wed, 27 Aug 2025 05:04:39 -0400
X-MC-Unique: 7u3lETN1N8a-yOR-Dkf0Lg-1
X-Mimecast-MFC-AGG-ID: 7u3lETN1N8a-yOR-Dkf0Lg_1756285478
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-71fd58c2ef7so77401847b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 02:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756285478; x=1756890278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fw8PyVzU9d4ukCHpPAAs24WjaVsKl7BVkmu/tQSiZdI=;
        b=rpl2hhwWNDP2DIR2ym4lr2h0TpHxKmc+mD7/0PimZ6qS0OoMxNLj/S5iQUKGNlPoWN
         J3B/pdk6n/S8IGb7NaxZBjUzsbDEOuGpZAyC/TS0vUcwADrjDtFxYqeHlfW2dq3MHJDT
         CN6uTsv5DtkMrQ8eyK4hD4gr5hTQcc69MIcy/u9l/yLd5rMpYIeQ6e+yV+2LEx9gAASm
         CJy6CXnezC1+uaIdTjkSLLA6nKGWMjljEOl8RunO2tzx0AqtP8Tz0MV5kicGXAP2OF6y
         96+8YYXkprbxTmvtIMBxDDoHYv4aUwLeBHFZIDiicpKyult1ZNH+oyg3ney8gjcqv2Xw
         gm0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+UNd/HQdwY48eJ6F6BaviEH1VcniJurvlNw5Njt4qpnORUiMEeCoozqcBDyiIIu8lk29MVk9QFxMxiTVA@vger.kernel.org
X-Gm-Message-State: AOJu0YxBUbdZx9/0yK9P83XjNjhUGTBW3a8aQzx8mUZNrSxymSswcj0i
	IwSl3aN7JE0yh/bf0XkOUVsHCM7Tzk8VSgXE61weCJu7RF19Hqg5SKMpc9CUIP8wUnmcJzynis0
	G96crJz9UkB8CbhtL5JGalTz+OWfhF8AY/fF+spV6gAxosXEtg1WYQAP65W9z7OHob4nwsEoKXM
	kKMxJVQXmochwkK7GiZV3nnmxofiw9WCZcvxKlvNYIkw==
X-Gm-Gg: ASbGnctJS5O0JMlSQIza6DmkEBqu6JJhnRaI2WH7Qs06sb/9exZgq71ioKcEzwin0g6
	Zoleuix5r8U/JXz6fh/y7zjzA87OTMtUGvT0XHnPF6I9Ke7ogA2lIQuk2RNpTFU4E41lhTWIzAX
	Sw6feQUL77/TlVLfwegZ2XmlI=
X-Received: by 2002:a05:690c:6c83:b0:71f:b944:1018 with SMTP id 00721157ae682-71fdc5601fbmr193662127b3.51.1756285478408;
        Wed, 27 Aug 2025 02:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTytiV4AgWxnglyZ9sfr6QlKR+oMKV7UZIXieVrKzbrQmX6GIMjVriBYn11zlFe6XtuWdxojbQC/micNkjEL8=
X-Received: by 2002:a05:690c:6c83:b0:71f:b944:1018 with SMTP id
 00721157ae682-71fdc5601fbmr193661907b3.51.1756285478029; Wed, 27 Aug 2025
 02:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822114436.438844-1-mszeredi@redhat.com> <CAJnrk1ZbkwiWdZN9eaEQ8Acx1wXgy2i2y4-WsK3w+ocYuN6wwA@mail.gmail.com>
 <CAJnrk1avdErcTcOAMuVTof4J_csc-k1vtq2=9z5Jpqws=VCY+g@mail.gmail.com>
 <20250826192618.GD19809@frogsfrogsfrogs> <CAJnrk1ah4rUNz6FbR0fWjJ95i_pNKmK+vWXFwhvwNak6z5bupQ@mail.gmail.com>
 <CAJnrk1bAT-oDctFWmLK+uFwgGnTQqkqTYBG8FsS2cYWhW4=mYQ@mail.gmail.com>
In-Reply-To: <CAJnrk1bAT-oDctFWmLK+uFwgGnTQqkqTYBG8FsS2cYWhW4=mYQ@mail.gmail.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 27 Aug 2025 11:04:26 +0200
X-Gm-Features: Ac12FXwxRY1Hx38a992ts-vH3kdDFLMJNt2H3tWm5wbJVpfhFkh89BwxoxFE-v0
Message-ID: <CAOssrKdHocHtHMeSWpTqd=YgKQsMFE6DB7fXt4Cu9JicAvXVOA@mail.gmail.com>
Subject: Re: [PATCH] fuse: allow synchronous FUSE_INIT
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 11:44=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:

> Ahh okay, I just tested this experimentally and I see now where I'm
> wrong. If the mount fails, the .kill_sb -> fuse_mount_destroy()
> callback does actually still get triggered.

You're not alone in getting confused over this.  Super block
initialization and cleanup are complicated sequences and not hard to
mess up.  Thanks for confirming that it works as intended.

Thanks,
Miklos



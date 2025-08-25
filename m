Return-Path: <linux-fsdevel+bounces-59140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C90B34E36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 23:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94B61B25C38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 21:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8213F2989BF;
	Mon, 25 Aug 2025 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egDfgIxN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F936221FC3;
	Mon, 25 Aug 2025 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158194; cv=none; b=IkHGgnfljKktHthSm74AreLA1RAuEnZnu8q+Ygs1sedKKBDjNYq0OU0juc+hIlTy6FYdN4JegufO66ky856kKWOq2CQISDBxqSjz09tMC4w9b8cxokAP4K8S7Q/64qXnRkc+t3tA7qrhNHq0SFeepGI3IaTYWsLcFu2bLbiSxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158194; c=relaxed/simple;
	bh=xxIzkGDR321pyccex9pUY6O9+bueEK+mXm6r/XKg7Oc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=duY6qo4PKdXbZ+7CZ8IKghf2AJkgRShVPs8oCY9TLKTiCJNYxlTHNwtnySxMsxEUM7pZHMR/wiavmwwdnpN4CrFbjcnNmItmE21mCkkr4rFCKg+826ohTl9JtlpxuXNtBJlISHJVhOWLEMctwdi/wPerkrxm4SXpxJrngUeLhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egDfgIxN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7322da8so788391966b.0;
        Mon, 25 Aug 2025 14:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756158192; x=1756762992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L1ZdiOQ+ocy7kIerFqAydo3pqaL3JBB3Sf5gIxDSEQs=;
        b=egDfgIxNg24wgktpx5OdMrRJUQ18JLsphm206i2yWmm2e2VikSU4qPluq0D6AkGqDk
         GC80ndzt1MmH8ZnPktKmzz9ZdIxFQGzzj3Yq+Rr1KxHbc5QvU1OJzjdisG2c7/BdItZO
         YP70/6viOAPUxWUSBTEuyeZu/w5Irxcq5saGewcohO+lGwTawf31S3KRJjdGbBgEproD
         tZLOnng9MCpgBZTNliKRNZ1/SL7qUDdd2JURsQ5q/CAu6hISZ+YIx0Q3yKQ80fa4Bj0y
         Y89+kBcKNkxFHsKIAvKZQ5DOaB8HYl0XVkODqRsDxePbStbCaKPUJHQUR5xV+tyaM/2f
         Zs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756158192; x=1756762992;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L1ZdiOQ+ocy7kIerFqAydo3pqaL3JBB3Sf5gIxDSEQs=;
        b=iPLjYfdlrnXGGY9fSJwiUcJ5ecNCTTWz9K1Yrpif+bZEIzb5n9g6aSa+h0sU6f250M
         URv/DCoHVZZzMCkDcABuXVPtzLizG4bQrYre3M7ka3gAAlC7e4UqiJqyg4n+ch3QBYsD
         tG8wX9tCiHRP8KBdU84vFW9jVxkrEdskvzTnprF5lVOUhY+DUvezyPFxhbExfXnd93Fy
         z2yW4e6cHhLI9F1AoyMq825Wkp0XglG/GMYVVi4WCViA6x9OlkRyecLLrRjYpqiU7hyr
         FRRcpr7jql+IMbK7s73Cnnc3DYbOjxqqX3sAS1aeJ5sqA6BNvfwpc1Vl0T88rWKui1EM
         ZnPA==
X-Forwarded-Encrypted: i=1; AJvYcCUCleWHptCy0O2SjKL8BDY9rAE7V1mrxxEhVU9e0PubuWa3hE+c+Qjr7vXf0kiQ28epGuDYuBEze7jdCf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuCmJ3E/raKWPEghTOzqZOawkp+Bcyim8KJyR8pZ4jiOS4dnBr
	crUg6TUYrP4IQ9HSbsmlPUuMI2rpu7VBGIN3zL5i5C0TbGGTfjkQCePaeAM3hU+BPoW5Cn+16Tg
	/Yx0MjUzb+qdnYOf1JPsH3D/Rp8McBT4zNXG5
X-Gm-Gg: ASbGncvq7vXyXDdno9VchGG2djomQqbT5DzW8r92b6c9DzGAb8rafMZ6GVsD1GP9RhW
	f3oxNKaLc9/qs17LEm3VtwOc+USQ9lvLr8DL87KCybvN4kqGRpVtJhbhPjNmOrmwPAxottTDUFt
	au9eryaqpaVrPNUGhicfWulk82Ci1AWMznt0bW15iUma1GhpoNAIZenunEX+373x05UqzFjqkwl
	tcr/g==
X-Google-Smtp-Source: AGHT+IG2yTyhHVml4GPr3jglTwK6YUTCOb2EGrJ1BJ46haG6NyaV3qSUMq0IRz5ulurjXu4Fv+OZ98jwWRmXcs+Tpg4=
X-Received: by 2002:a17:907:d28:b0:ae0:d201:a333 with SMTP id
 a640c23a62f3a-afe295d28f5mr1398848566b.30.1756158191684; Mon, 25 Aug 2025
 14:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 25 Aug 2025 23:43:00 +0200
X-Gm-Features: Ac12FXx9MwjgcuYmezIpIsQMoDHzInyHPpVRZ_U2ucNETDbC6af76PejKfFTQAA
Message-ID: <CAGudoHHBRhU+XidV9U4osc2Ta4w0Lgi2XiFkYukKQoH45zT6vw@mail.gmail.com>
Subject: Infinite loop in get_file_rcu() in face of a saturated ref count
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

__get_file_rcu() bails early:

        if (unlikely(!file_ref_get(&file->f_ref)))
                return ERR_PTR(-EAGAIN);

But get_file_rcu():
       for (;;) {
                struct file __rcu *file;

                file = __get_file_rcu(f);
                if (!IS_ERR(file))
                        return file;
        }

So if this encounters a saturated refcount, the loop with never end.

I don't know what makes the most sense to do here and I'm no position
to mess with any patches.

This is not a serious problem either, so I would put this on the back
burner. Just reporting for interested.
-- 
Mateusz Guzik <mjguzik gmail.com>


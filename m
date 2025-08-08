Return-Path: <linux-fsdevel+bounces-57124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3771B1EED4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA0754E06D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0438E285CA9;
	Fri,  8 Aug 2025 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUi1BPrs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04D1224B04
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681336; cv=none; b=b40HmPAGmI5VyefqNPRLJ++T2UivC+6C329x+1q7Zdlzxy9MFHA6hcRx2B5JS1KJp39FlxuCLjB1zHtx/gwpeEhPttMndqAhX1bUHRisv9x7rMZyn1xRND0aquuDlfBSyLR/BG3TOiTn0VdGFKn49yYUfzi60dDCJF8MMn45W4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681336; c=relaxed/simple;
	bh=QEXhxovWYUHVgBkEl/gTdcNOIaqUcKQWivj1PPJZ8ak=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PE86y0zlJtm9DAf23/c6oBZgsngfTuUreCTQJq9VeyYq6/tJWoNzas8NDA+MWohUE8Zqf4CRCjOPyCARp1YqOmOLcuGddXEAZAonxiQAuTIFiwS3zWEIl3ERFHqS6O9sygDcpcoOgsyoT4VxUaqRoAJr9YFVg+EUstebQsp9nZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUi1BPrs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754681333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=z+VJfc5dyu/GsDQ2jOZqvhe7ZEO+uEqdgkyy6rtOglw=;
	b=DUi1BPrsTUrsFwjKg9jL03qCweG0xA1/hE9kg+yLPLTjzogdLZFbg7c/3eXWZplIGeqh5a
	bC2zVKu9jar8k3oRJ6mNNP9qlHqWcHyji5xpu08S0p0UcCYbWySt4sfexo0uGSjaqo5fT5
	dG8X7ftAdwFc4Q9YFXm2MC+1Y/Q6GYM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-AI7fOW9hP4e_HSMykff0uQ-1; Fri, 08 Aug 2025 15:28:52 -0400
X-MC-Unique: AI7fOW9hP4e_HSMykff0uQ-1
X-Mimecast-MFC-AGG-ID: AI7fOW9hP4e_HSMykff0uQ_1754681331
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b8d62a680bso1371462f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 12:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754681331; x=1755286131;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+VJfc5dyu/GsDQ2jOZqvhe7ZEO+uEqdgkyy6rtOglw=;
        b=oXImKW+wAC40ZhOAB+Z2ZDzjAnCDzvQMgKhmPgxvZN6jmC0PybZothCOaAmnY0OyDk
         wwm7ujwNEhfiM42nv8rG7A//56VePlaRaIFcjR/YpWEPtd8guJWKDSN3WYcS2yVHdeGe
         HRce+e6GoL48EKDZqUaeqPfBwblQxmEnxx10iHe2So+W9SUT3IYuskmcqsLIQcMpQGQg
         ZaZ1An/BR4p8OKRxLCNK7mq/Aa1+S7PCBsmEjEapgfqxc++5nCF4G+PDK7p7DBjkzfPI
         drmsRvcjMnOkDbh/oD3IDyxY/7+Lc0fZk1QtrGS+UkiFut/WpbXGsQM8LOaZiMaKenGn
         GlDg==
X-Forwarded-Encrypted: i=1; AJvYcCU8c3jVlAG/AH5kCwO0G4kGGi9+S7DAKWlTIT6vfSTfZ721xTqyXiCy3yuEr5WAEK+XnwBrvZo8tqIGhQr0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/5F6S5fah4Xnuy756QFke2mYrQHyrJJ8+Tv5gkPyUMQmrME3f
	yiR2O9245kYlq+G7xN4azJosq+RGrL5E94hQxkf3+E4JTkfRp1HJQNv8C20BB3NAHO9a6HbI+jI
	Ha/I3zgCqLnQDaZ1XOGqVyXZUhWt+zIQGkKBI0bdI9+2fkX3mahAxy7n5u5R+FqfOHg==
X-Gm-Gg: ASbGnctX3haxvVLC0A7TmExaICBStAtmFV1QLWjS18X0tpF1urj5M2HgjKBTqUeoDRx
	OcPO11vAM6ze59xBFjkOyPQWnypOoKo66wKGbbrfVtepcsPdZNRaTJEd5EloRwz89+mrGBwx1+I
	7fIjBpTroDv9S/TOGmlLRc5o9S8XrSx/Okx8u5mXLGJCop+iekHp3DkyypBwj9RjtoX4klLxwqv
	dShnzxrTB6C+77VdGzihbbBMtZk3Gx/5p1ZmXLixvsS6DlJLkS20LCzZEN7sgL94UgikNM9xmBk
	5pFkdfkqnc4MxoqNrWwYsaq4oLL4CIkIkd4qEK3UBV01g7jKYqCvZnWEDJY=
X-Received: by 2002:a05:6000:2209:b0:3a4:cec5:b59c with SMTP id ffacd0b85a97d-3b8f97f4ba4mr8240465f8f.25.1754681331221;
        Fri, 08 Aug 2025 12:28:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI9xY/6Qpbd5IKobjzePxeB3jT7K8h08kAJrvDGyK5ww5Cu3HFMUyCZu/kR3Zamj5WJ7zjng==
X-Received: by 2002:a05:6000:2209:b0:3a4:cec5:b59c with SMTP id ffacd0b85a97d-3b8f97f4ba4mr8240451f8f.25.1754681330861;
        Fri, 08 Aug 2025 12:28:50 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ad803sm31036606f8f.6.2025.08.08.12.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:28:50 -0700 (PDT)
Date: Fri, 8 Aug 2025 21:28:44 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fstests@vger.kernel.org
Subject: Tests for file_getattr()/file_setattr() and xfsprogs update
Message-ID: <lgivc7qosvmmqzcq7fzhij74smpqlgnoosnbnooalulhv4spkj@fva6erttoa4d>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

This two patchsets are update to xfsprogs to utilize recently added
file_getattr() and file_setattr() syscalls.

The second patchset adds two tests to fstests, one generic one on
these syscals and second one is for XFS's original usecase for these
syscalls (projects quotas).

-- 
- Andrey



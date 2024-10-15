Return-Path: <linux-fsdevel+bounces-32033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37EB99F752
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 21:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9820128313C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 19:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3201B6CEA;
	Tue, 15 Oct 2024 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFNWg8e5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C981F80B1;
	Tue, 15 Oct 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020597; cv=none; b=UqbqYNeyCPOLfuf3XKzBWmF7g3aWXnfy9b1H5QyR+nUemo1WbP5+8zC6GhyOU2xd2LESTkuWLGVDmVSZX/uwF3QxRtnOz6hVYzy76K0qXMeJjX0XP5AqcQVW48FxzXU2Yu6FdsW+GbQuyY6Me9JefPpMt9PXbCU0wUVhZHK3H6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020597; c=relaxed/simple;
	bh=3MlQeXB5Uu9IDEgbalmWpVhMVbn+v0dHKwOLs+42xro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DW5xQtPOgpT3a5lW3ijXNNmIpZCuPhzEfomUj9iAjadbeELRy531wR13WhYDYz2rxg6JMBvBa70cmHdwHcRkRY9lzkesuu8Pb+nRawegNunpURrA9bQeu7h+WIEceicJJyRFjOfV5T33seKx6Q1GDE3iNAkSG9+S/AhJZAjWbgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFNWg8e5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d43a34a0cso296399f8f.1;
        Tue, 15 Oct 2024 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729020594; x=1729625394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3MlQeXB5Uu9IDEgbalmWpVhMVbn+v0dHKwOLs+42xro=;
        b=CFNWg8e58CFZIVQZG8K+3KpSKJPxKV437lxNzmUEWHdjSpmoynyFDqpAo9FvvVD80r
         G19jYDNH3p9+Qr98IyQu50fLTiWux45wP3gn9siCYRnmhDGsXV4fjaRKo8t3jgoHqp7c
         NLpOjupywot0AKavJSltACi/Hzs3df00HjnjbggMkNFBLkC/4dgd5NDGufYIca4tbxli
         YRvKy7i7i+2rD5mojVa9DMhq8RY2mskEi0mvIfrlJbYNx4dbrA2V/s91B8LOZDfaXBy8
         iQjZplUzjuiPpqbcOyCHM1XxhYuoOKM5gDaeOOZyxqhBfnGbbw1FuU6kNfDdmM/Z+57S
         3Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729020594; x=1729625394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MlQeXB5Uu9IDEgbalmWpVhMVbn+v0dHKwOLs+42xro=;
        b=TmRihBQb6NIHq1FNgMuEikSGNr0c8D1X4pp3o6XsyIoBKdzKzfvUzHEBjTSEuupYVM
         Hs/DKlGzDa2K/1ni+J+8S9TdJD2RXGUHoLuhFt4AvcKbZHp7Vjc2cdN2r0sHqtcBfb/F
         V9rMB3mMFz3Gamf7ZGKD0ssSfFbuzQSqUvFAY9U8PFI8CcEZTO71YSsrQcBqwhCdemXV
         oLZq9S4KDe4BFov3ym5WQ8DypVhjvSdclZI2KkTLFOa458oZSysvt6siWw7zANHCcNUz
         mFodU6fdG57la7Emow+l9DCsrcR25ZjGhfOMWnqjJKGt5ke3OEdgnJbeJMyDyEcXIXTr
         rIhA==
X-Forwarded-Encrypted: i=1; AJvYcCUhMO6yWfqEg7tFtRBuqwThPjwBspfZ2JCxZFQf6+eKCF5qtFM9qBuAYBMBWXjqLJyTF91123WddX+dAYxn@vger.kernel.org, AJvYcCWm+Edp9je05nb3t1WeCNf7oO2BO0zFPpj3ex2Tc2OdROo6XHMO6hgbDyhvLqmnVx/fPS0EB4jeNlWxw6BJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwkxSvKw6JH+sGTZbNBq5Q8F5HRbbRDv0dWh+kwoCvuC0e8+s5J
	jFLJV8Hg6p2VcdoLEHHf8uPfF+y3SfN5BL4BZJHNHzV4uLE0hjKfdFKue7BLP7pDNOz5uiDKCVT
	gIJKkisr2MVqCOsWOdx02ZcdRSpU=
X-Google-Smtp-Source: AGHT+IGPdIyu+Re+h6AdGMA7dR8cTOxAkTJmBqt/2MNdugsUtA6h2XWeKz9G/gGs5zqDwL09aI4HEsuz3GIqDWmQOsg=
X-Received: by 2002:a5d:47a7:0:b0:37d:3ec9:a01e with SMTP id
 ffacd0b85a97d-37d553505f3mr5712067f8f.13.1729020593683; Tue, 15 Oct 2024
 12:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jz4OwA9LdXtWJuPup+wGVJ8kKFXSboT3G8kjPXBSa-qHA@mail.gmail.com>
 <20240612-hofiert-hymne-11f5a03b7e73@brauner> <CAJg=8jxMZ16pCEHTyv3Xr0dcHRYdwEZ6ZshXkQPYMXbNfkVTvg@mail.gmail.com>
In-Reply-To: <CAJg=8jxMZ16pCEHTyv3Xr0dcHRYdwEZ6ZshXkQPYMXbNfkVTvg@mail.gmail.com>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Tue, 15 Oct 2024 12:29:42 -0700
Message-ID: <CAJg=8jyAtJh6Mbj88Ri3J9fXBN0BM+Fh3qwaChGLL0ECuD7w+w@mail.gmail.com>
Subject: Re: possible deadlock in freeze_super
To: brauner@kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Hope you are doing well!

Quick update from our side: The reproducers from the previous email
still trigger the deadlock on v5.15.167 (commit hash
3a5928702e7120f83f703fd566082bfb59f1a57e). Happy to also test on
other kernel versions if that helps.

Please let us know if there is any other helpful information we can provide.

Wishing you a nice day!

Best,
Marius


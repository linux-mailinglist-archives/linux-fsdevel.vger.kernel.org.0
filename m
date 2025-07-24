Return-Path: <linux-fsdevel+bounces-55972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7BFB111F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 22:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1491D7B19C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 20:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E104B239E64;
	Thu, 24 Jul 2025 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNQKAcu5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01C922D4DE;
	Thu, 24 Jul 2025 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753387382; cv=none; b=HFxUh7G18Cn0g0fHpOrqD0lCGSOdp29kPQpGm3RYzNzI/bBFiL7Ns1yBpZfiii+8p9b9QldjN6mGQX8BfPbSqixvhyLxxDTD8usnE2QQkAVc1z0IXTubb7IMvnqvCubRvk1o0tWOolgbXy87C2w9pkT8PbxmhA+ULKptDSgx8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753387382; c=relaxed/simple;
	bh=SNV2ZucN+Q1Y8ewyvUY7RD5mmK5kS0ErsQsL+X/B/Qc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fUiDuV4yGu4ZsTNMbFECVZ+h+JdWkHddb+Xin15xUDNFANxwoW0a4RYXnp28hhCqpkI696+oWKI3uIBkmj7HjsUERQWoid4sDWMp1zmdrHHBlbJ3r2cGZdpIMJRzcfiTA+UFlvZxKCsJDHD9U0PYmbw8tK3yOIM4n74KfoZdMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNQKAcu5; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73e5e3c6a37so880938a34.0;
        Thu, 24 Jul 2025 13:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753387380; x=1753992180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SNV2ZucN+Q1Y8ewyvUY7RD5mmK5kS0ErsQsL+X/B/Qc=;
        b=jNQKAcu57gNkBjFBvSKWuCu8LNVJ7/SAY10u3Ps90JmgeMJDy7tVvXXD+qtG//nl/C
         ixuLBhVs3iww93l8LvsQArJPfsjWd0cvF7K8vPIwCJu6yK00zYoB61CIIYFZISD2+Hyx
         WT7Ifj8FLBiKlpdfOVbocGn2zO/cBV7nlMsU03J0EzO7qoXy49nhkBxZ6pUubbChDESX
         VW8Gxwv8d08/RZAKczuhCjxQjK0BNJE8rNOqTxZPZXnhlukTG2MaW1mn8x+g5A6bUqHW
         ksETnEdf2PC/F5Z3VAnJ+Zrh2KsKEHyFTrb6xo/Uo4FjC7fiudBzOdTX5AeekDE0Y/oU
         fNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753387380; x=1753992180;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SNV2ZucN+Q1Y8ewyvUY7RD5mmK5kS0ErsQsL+X/B/Qc=;
        b=HRJyrBNWG3ScCwTBzhHxo0WnuFN2SW1tj/pkfRip93nRdyRU9dkCx01js3ktYx8hcv
         cNZzUzsZMVNZP00IZhEaG/wk81FQubmXg5Fy3pQsgw/tQkNfCWsowvu1znRr7pdIPQys
         vetpng52yEjDaNXsdBdhgTavuPerS+4oJ6ONU93zY75z6w4OYwDGjQVN0ql/E/H5dQJs
         EUa4hy/HkRFT7XL9LWm0iDGC20uelhEnhSmdGNH6TB6q+nl8+Mx9WZDAQjBqyBv25m2w
         WcQzVHmB3+JBUeT1CARLwAd/bX3hLbDd1qKrVbHlnN3/i07T51wArLDwMqqQGcXrs9p5
         rE+g==
X-Forwarded-Encrypted: i=1; AJvYcCXKCUq31/+BBqSfutapPySJqQNHZpck1skWLfH5k+9HKnqh+ETJHZIHWh/gnddmQDV/DIJ+gTeggLqWEsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkftYkUatw52k00NjI0GdkuHlCODCi5jrVyihFxK2/9jGxP5ON
	uGYyECQAbTeq3STSx/ocwkilrwnxbNbfp8PAgO8L9R6S5fqxk5gNFIx6AJq5g7TIjH5Z+hnwsym
	zYG3XD1DiUBpjP5zYBfXMAy+YVhG7URg=
X-Gm-Gg: ASbGncu+jkS8mD8F3/+Uda078x5bEbW2BOTGpPGAdjWZokhMQevBJdUbMQAt2+M9lGE
	yb6N3HfS6VmdgxyHYAn/ktHZ59/PqGrJRlVxdsl0OFoSXrsGSYkxydhe9gzhCCWXcHcbIp4HYNL
	BrLJhpSW70qa51GQyLGy4cg+wsD/8pH5GqeaCWdKwaGw7CdrM8f/lXbEXBsJiKiuoNN5yXZh6Sp
	z1Q1Ydz
X-Google-Smtp-Source: AGHT+IE+z4+xt5cvZ+sXihIbp5iDRwg5tQkdFEtlsrZEuapErCdlSkVx46rbdIIvCbU8DY+6UACyfyOSk8YZvE56+Rg=
X-Received: by 2002:a05:6871:b1f:b0:2ff:9c45:4f51 with SMTP id
 586e51a60fabf-306c6f9537amr6140736fac.15.1753387379904; Thu, 24 Jul 2025
 13:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrei Vagin <avagin@gmail.com>
Date: Thu, 24 Jul 2025 13:02:48 -0700
X-Gm-Features: Ac12FXyw8K1x7qoG1tqDHURxg0BFnQUWWS9fJjqqa70xX6WKuXP5HZvWasYYtZM
Message-ID: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	criu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Al and Christian,

The commit 12f147ddd6de ("do_change_type(): refuse to operate on
unmounted/not ours mounts") introduced an ABI backward compatibility
break. CRIU depends on the previous behavior, and users are now
reporting criu restore failures following the kernel update. This change
has been propagated to stable kernels. Is this check strictly required?
Would it be possible to check only if the current process has
CAP_SYS_ADMIN within the mount user namespace?

Thanks,
Andrei


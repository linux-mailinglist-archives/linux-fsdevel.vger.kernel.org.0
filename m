Return-Path: <linux-fsdevel+bounces-45413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C9CA7747B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 08:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A4D188BB3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 06:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062DE1E260C;
	Tue,  1 Apr 2025 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay1vSseR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4B131E2D;
	Tue,  1 Apr 2025 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743488958; cv=none; b=Dvh5QfTwTV5HitwO+9fttueyWEAM6UO4BOOrWmjf+PuAAorPf1HLAa/G5e1XMp/y+lO/96ZtmJHQ3Ueh889M7UIjOQKyzE18tpUlqqEqGzFHNmRKoy6k3XLCTGRYSR9A/wH5QYDrSnr8t7noTZnZM4gqLJDoEgP5M3okSn7WaFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743488958; c=relaxed/simple;
	bh=TVeq6PNEiePIMl+ttaOJNKTUK4jVxSm94Q1sT2OShj8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=E5/qVLKe9b3LzmubjzLeGvArovHrU8Ao0Z2MU6AbedxUDFbwPW0LCVHU2IPGI5Fc89KLE2T7K2WBfvVOsjFG3aC0oVncKu9q3wymUHEjR6L11TPMG0S7/H9ipVuLhsbeCFcc9G8yOEHI4suBu3AJZqSL+LzzCxiCFc2V6eWBW9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay1vSseR; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso49798571fa.3;
        Mon, 31 Mar 2025 23:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743488953; x=1744093753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iNphk2i9eSGihLD4c/ofcPRkoFOwL4x5wS5sCwun4uQ=;
        b=Ay1vSseRX3sXHw3vrVXZjaJPpdE5d8R4b51dc/GVakt3StvfgUlVrXqqZoBBYnmHNh
         yqQbDI/Y5pdJZCYVxpaoZE6Ic9+sPjBuQjJfOk8x1HOc1/jGErp60ixtk4qsTc5ZJ4QC
         fiWAh9EtRw21GV/HsUV2xxNh0UkNdQbiArTombIFgahsjo6VdDNCVtNCYf1rxgSwpodw
         zfPIpmvuysvcdg/FR0xYBvrh0T5rHW8v9AwpPIdJfK8aWoVmGznLRwfmiKTB2M9FEkCp
         av34MWgsf0MBx9yJeWa7WzHDy9Th9wIjkjjd3V/tplsyblPM199YXaY22/li+jQt6sJO
         xy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743488953; x=1744093753;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iNphk2i9eSGihLD4c/ofcPRkoFOwL4x5wS5sCwun4uQ=;
        b=tkroVjuwBNpZyXqn0++hUb3aaSmyErpjENM57SBzD+jn1e8lIOfzbqr1xqVwyWH5+K
         JW1+zC0S48OuWdCw+ZCTZKTaVp00O3PndVhsN5aaqYlLSsiim51/lGsXehXao9m+1CBe
         wgOfk+CuFXG1qjNEIzZWpXosPBTXQQYQxpHhjLiLkGkdW/c+pQnHHlQVHjbySYo3CA45
         Uug6po4ll1rLQg2qr2v93sqdmkR1b5zVCvSzrYWfqxBtY2Cd/1WW3fGOzqsU65O0F364
         z4EECaIEnxDGxlv00Y8Vz05axX14DV+WwkLenElcHDFyxpIrYS15NMfzXzg1UfIrtVpN
         AXsg==
X-Forwarded-Encrypted: i=1; AJvYcCVmhse57UEygeMLn6ayQSEdOSj/oiCyN3BbAOV5CQRGGddckmZVDZ55HlPwJB72z6ohuNHdzYQuzi0RIaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPv2FpJmrkZLE4eRbTjetDFI1K8At3JDzvkHB4GeIyBJmuy5d
	XLnYW4lFr+lXrxswYNcVI80D/curI1x1dLtevwRTbZQU40tZKZhULbZ1LOQy3z+3NeCp6t3uPxA
	zjXUnwAMHKhE6B+uqLsM+gW7dGi+UPw==
X-Gm-Gg: ASbGncv7ocwwOEYhYfnqZcFGxJedebnqH6v7fAgHAlkDddZTRHay8mxIFWjrPe6WEG+
	2MnogFSeJKnTPoSBfixN51dAqWSd5s724tiGIRZPKhE0G6i6iVc95DyHP4SrKiqdGscGuZ8NNTb
	08qIrE8qRKQMzlE5ajakBOJ5WTWizHiabw9jU0QmTInD6p7WnspcAsA6V2KLWk
X-Google-Smtp-Source: AGHT+IHHb33VIGfYVihNIXGdVHC752JKSHLPixUm9AyM/V+3XusGXkJRkjpV7z3RF2DVCGWi7oJJOKFLv5ekMkl21bA=
X-Received: by 2002:a05:651c:2210:b0:30b:bb45:6616 with SMTP id
 38308e7fff4ca-30de0313c4fmr38698831fa.29.1743488952364; Mon, 31 Mar 2025
 23:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Tue, 1 Apr 2025 01:29:01 -0500
X-Gm-Features: AQ5f1JrTpZiZZL9PwfxIh7sDKeUI2uOIEH5Ba6569lQs35KVPC0DdGGw8xtrPx4
Message-ID: <CAH2r5muupgCHf99YziMCFrjYY0EJbT9W74TmUq74BtfR6kmOLA@mail.gmail.com>
Subject: test generic/074 slowdown with current mainline
To: CIFS <linux-cifs@vger.kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I noticed that test generic/074 (which runs fstest with various
options) runs almost twice as slow with current mainline, compared
with 6.14 over smb3.1.1 mounts.  It doesn't appear to be related to
changes to cifs.ko (as the cifs.ko code is almost identical in the
test runs I did).  Anyone else noticing a perf regression for this?

-- 
Thanks,

Steve


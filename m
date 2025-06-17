Return-Path: <linux-fsdevel+bounces-51980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 157EBADDE75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 00:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CD1400713
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 22:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C113CCA6F;
	Tue, 17 Jun 2025 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3h7SjuU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE71514F6;
	Tue, 17 Jun 2025 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750197624; cv=none; b=C5KeDCdAE5RfHbN5cLrZy0sSx19qP7fMAP89Y5X+3UttRgYdFFxk0/ArvvYmXgiWT5y3T28QYYnDouVNXcuqJ++4ew6CM4N3Z3XewPyCja96TknzaFevNPIUVUvpBohU8PRfdnZRCr8Ya7uJ5Kf7bDm3G1UO4aDQrclE7mDUZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750197624; c=relaxed/simple;
	bh=zgs35h9EtiQj2gsIkYN3K/XBSu+19KdaRfCI+ceSC2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChHVk03qlcYocNOYfwIO7tDzbjHnFxc4dVAZp+zKM3fU9OF6nLrmzHku0naeY1KO3k14lmK2FFhjFn1k2GjcEUnKjhLM4lxsMC2zoMh+U12mJ0nkuctjQ2ObQlpgX4M5xjH0OQTVagG/CL1GMBNM9b/IY+OnqROBIfKu440oYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3h7SjuU; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a6f3f88613so62408441cf.1;
        Tue, 17 Jun 2025 15:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750197621; x=1750802421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txIUBFwdzlJtz0AE1b03VDLXigNRDHeYfG75FQwge3Y=;
        b=L3h7SjuUgWAaDW8vzkxusq8aYrIRojyFyXzyfTW8nq8RkIxqFVjNrXw/2SimpMnXqn
         ZGgEfunmIiZEysIq7vTpNY8UYgirZ4/OPa3tT5xO5bfETkC/RFIVlxSm+FwQokqyqS6q
         1o0+dDGTywivCmXkvT/xlhU/XlZPTganVqSvElbwvCJpx3Ocxzc6Yp/2Ngx+lnxM2Ebs
         CSUQQEFgug0lAeydn1NtDyWh3bHoyrxk/7zmYCHj24Sxk6+zxbPmkVTNq88ZIVjIlKYd
         jTFrlG7NsR3697jPCOCy3re6b8r2MiiBiPHTP0nwqhGGyWrlkppAdtuyS75ZZ38oD+zy
         jutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750197621; x=1750802421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txIUBFwdzlJtz0AE1b03VDLXigNRDHeYfG75FQwge3Y=;
        b=ALhLYb0GuvbXNjggBDOVhOKWqVoDPZkuQ32cMcNVzn0urjDZg/kWfz6rNYuRjv37sp
         WqiibIBceR2jtL+CV7FmbXVgQjxRs7dN/RVrNxxSbSSpu8wQvJR3ykfJnNkfbalkaXBd
         tg7nkky2dsDUL9oaqwdwMyqDFLPyDiuGba2oNqclWbjJTgsgQgLH7/Yt99N5xNgU5Zxc
         fVKv098OKmxmAkLv2fzrhPg3XnSsG/iM0n7YR8D0HfoNAZ0NfVLgC+4DzSJv+96yfXRa
         en9bTKs8r8yH0TtB44n0wSUMv3rwNt6EvDOaxXhOEUFqJhZLvLDIWcsoLg9iOp2BtHxl
         DZtA==
X-Forwarded-Encrypted: i=1; AJvYcCWk4LZY8fids6T1H7SvMdJeahd03IH9NJQ3DBQZJoAPX/TqzKlm5eUdIPEP1KBWq9pp3v/pAX6nhOAu@vger.kernel.org, AJvYcCWnVyDLKIM8ePlisIDl2p9wCHlKgYAp3b8K6tqbh4M1msRFVmd/893EYf7DzUeLdloPUevRnOVLFl3VK3Y4LQ==@vger.kernel.org, AJvYcCWp61cnXNJMTv0JFwv7EUm8A3HCUUhRqTytZSxxmYvrIAcT2k1b0jmBglDK5MsWA8txuoAmfmFiUN7tbg==@vger.kernel.org, AJvYcCXms3dbTkYX++WSKxGU0ere0GYbSR06SUaamWp6Rlxonjhfxq22vb5Fzg82ss9oXPQn/uXlQyt+uSYp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Cned1rJgWMqtsG+kvEFDD2HLLtLuil1KTjo9RehA0wTJ6JDH
	fM9LlT+0xyGUnWVuVyxgETpNMXNMOhmNesdZnWEatLc+zIwOf5n1+19rM1WzapSZQaZJqhAIWfy
	AL3hptCEUCVMfYiQfB7uqxQ6enfqKy5E=
X-Gm-Gg: ASbGncsNCg9bVYU7Fz18j2HNm3XXdm2WGFHOs611VEEkQjwqwW/XjSq1Xl33lYcpet4
	sOmA6KvX+zySyXGCn5sm8GOQHVF9Y/XYEbBWsLisLYpd68ye1xSp7/4Hm1rI4mD3xQC4YGhz3js
	U0HHi0Cu9QTJRWoKBzIwgFUG0qAJmh9Blm0R3ZSoP/CwsTl7G3uw5v7sIkP4g=
X-Google-Smtp-Source: AGHT+IH0hdfYxpLNGLi3uEo213Cw3XqtMJ0PMjt6sD7nPMBUnc5OJF7u+w4++qwD5412WYS8skQhFb31RzNJBQ9+/x4=
X-Received: by 2002:ac8:5949:0:b0:4a5:a4e9:132b with SMTP id
 d75a77b69052e-4a73c658c18mr221573461cf.48.1750197620736; Tue, 17 Jun 2025
 15:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-10-hch@lst.de>
In-Reply-To: <20250617105514.3393938-10-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 15:00:09 -0700
X-Gm-Features: AX0GCFvVfukB4jEEL0QyWt5wn8Z0d6yaU1T1xsjz2NFs3U_hou4mX4F2ZU4QqYc
Message-ID: <CAJnrk1bkZGBnRcY5kXoxrqt0OoGZTu_ouWa=h6mF2Q97StT4Qw@mail.gmail.com>
Subject: Re: [PATCH 09/11] iomap: export iomap_writeback_folio
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 3:55=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Allow fuse to use iomap_writeback_folio for folio laundering.  Note
> that the caller needs to manually submit the pending writeback context.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/iomap/buffered-io.c | 4 ++--
>  include/linux/iomap.h  | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>


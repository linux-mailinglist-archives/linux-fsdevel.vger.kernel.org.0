Return-Path: <linux-fsdevel+bounces-51425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D3AD6BA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 11:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6721898645
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E1D224AF1;
	Thu, 12 Jun 2025 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nQ+delIt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551341C3039
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719259; cv=none; b=ZeIDQfo4JXOVexh2NNbeTda/iiuVwIej0x0D+jSPnnHc4RGek4cxHOPI0WzSOnqSzzEL6xfRT6V9PIwn7HlQa1YIdkff/Ig1MuAyaCQqLGRT7Hozm/ZliDQBxa3cpW3VhjXczFDAIUwv0l8vRl1llTeQRdlJdxsc5MkdTxkPpVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719259; c=relaxed/simple;
	bh=y6b6QvQl+bRwXvl+wjLTqMdjZCkwY36Ul1Tt+SBOz3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObEFuRbObgLVB1tFspMflSKAvarkc0QiZZn1n6Gyg1l/Hrny4zYSKJ4CygfGY5bSsSlASUeBP0IUCUcpZMJXrnwm4v75yW2kw9Ty6WTXuJLWmAkjSCDwlPjCPF/juLVqldxXCJYx0entHN3pDzEHTvG+DodmcGIyKrcN/5LtKeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nQ+delIt; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d38b84984dso118534485a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 02:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1749719255; x=1750324055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y6b6QvQl+bRwXvl+wjLTqMdjZCkwY36Ul1Tt+SBOz3g=;
        b=nQ+delIt/jYSezvzaZ+DUltnffOECMTuv8Ll+traN0KVyGnPWehTsqQBfzCFQQoXuh
         JNbncd7vuton5M92AjJViNoD5+hh4SysIRFzewxg6NATJ/C5KsVJVOQsz3M2U6eBBv+r
         9yfT7LmJW/QnjFMrjBN/YOOZsYFQKV9vCMeF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749719255; x=1750324055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6b6QvQl+bRwXvl+wjLTqMdjZCkwY36Ul1Tt+SBOz3g=;
        b=cX8I4UdJtA0ZokRbnbbBioX2OlZ8rGDN5IaQQVsmZhazb0fKNZgNOF35jyN3Zn/kRj
         PpRsnsZuFhfSf5bVO3UR3gKHdoDow47HP6MODwsnJDn4ZbG+AnugFnjdSeh4x3xfvKME
         uGM9Sea+LxjzgitfTN3P7qySJLhl9Us8Esr1vb14ZV9LYcZ0eanl78DWuebm5cRGmKkH
         g25wnA1GP86m4SXNs+2+5gZlRp5RBmeun35AuGDYGuR/t4ugDs7OHoykYTDTj0vschNi
         zNpK55rw4AJ0psPYnpRtpopXOf5avbqLZWzAQfWHcxMZhWBXiwE28DES96bbHY4yPcfn
         IVNA==
X-Forwarded-Encrypted: i=1; AJvYcCU2RPcLJ0ARSAJlfVrG6hI2ScuTcWmhoZue0IbuyDzAncLrG5pO6q9NucD54rbn+E/1Nx0uyHjgCxJJ2YWd@vger.kernel.org
X-Gm-Message-State: AOJu0YzVde8jIIxjHo59lDWdU7CkIEY9TnTW8pAXdUjJv3f03opLvHL5
	Crrzwxg5Q+pp/XI1/HfSsweatIz24GRcIiPrH6GzzcLnm2sSk5vj140/g+0OWLilk7Y67qS5tm1
	i7BnkmZt6J3S4yNMatBLTLe6QbC96/lIKplpV7TgdoHB8zbUKsGiN
X-Gm-Gg: ASbGncuxQhnAkks9k/SlrJKN5HOCVb8r3Y29ED8N1ObBq7E5/xXuDz41Xq11BvWHHXx
	qQTBynWgdYojo+L9xiwtoLXPIKX8fwgHaMzE6xlHn65P31lgcyNHDuWUXOxRn+S9zgcHbN91Lye
	+F+LnjQ2GfVaDDIdVwy6ByiwZhzY/7Yf7BCHljnc+e56xB
X-Google-Smtp-Source: AGHT+IFOnNrzWjLT5ibrVv8Y2BGK48j7B6UvhBgwO8fx8UkM8EQpMGJyxzvavWuXra0V85HOmQFH97ajXAajekRIaps=
X-Received: by 2002:a05:622a:2596:b0:4a4:2d7a:994b with SMTP id
 d75a77b69052e-4a72293dcadmr52269271cf.19.1749719243891; Thu, 12 Jun 2025
 02:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612032239.17561-1-bagasdotme@gmail.com>
In-Reply-To: <20250612032239.17561-1-bagasdotme@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Jun 2025 11:07:13 +0200
X-Gm-Features: AX0GCFsOlxUaPAtzGm57tBtxM91bCOFZq--Te855323YXxbAnNwlfNn2nirhb38
Message-ID: <CAJfpegvKvKB+1Q23Gm8TKAmb4hPNnSHpK5W29JmDjHVWrWk73Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: fuse: Consolidate FUSE docs into its own subdirectory
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Luis Henriques <luis@igalia.com>, Bernd Schubert <bschubert@ddn.com>, Amir Goldstein <amir73il@gmail.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 05:22, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> All four FUSE docs are currently in upper-level
> Documentation/filesystems/ directory, but these are distinct as a group
> of its own. Move them into Documentation/filesystems/fuse/ subdirectory.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Applied, thanks.

Miklos


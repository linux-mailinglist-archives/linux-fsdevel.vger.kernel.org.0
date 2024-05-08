Return-Path: <linux-fsdevel+bounces-19125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC328C053B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 21:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE65B1C20A3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8082113173D;
	Wed,  8 May 2024 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2BbLOLJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D61311BA;
	Wed,  8 May 2024 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715197323; cv=none; b=O8rl7hB0Km4sXUJRIGwuFJArLl8F8ST92RzxXTY3iVAFSkG+1FnJC+OWgcszF3PbXbUmRRl82KISCo1GPL4tc/zFmnSx33wLA2Z9WJH5KvWMfz1rlqU8LlL6NJfxLYHTsGZEgA8HnLQM5bcTi4MktuQjKrcAFW1Cu8Kjompofqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715197323; c=relaxed/simple;
	bh=ZvMxS/6Il7AG6FkDa3UhAvJRDgJpxkW07GOyJVCjJzw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kGMPBF5i/vo4jn1pgDW0WfmEePod7iiUBLuV+jR3VYGiaN9wt/MGKpcnq2Np9sKDtK5cLnP6QHn7obrfODve4Ibd+3wwM8t8agsQO9fxW26A0SuwRrKgUNKeN1FBTVvV4eIRJhWlNYlDaWPMIm/18CoOLvpiGMY/kCo2gmGX3CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2BbLOLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125C3C113CC;
	Wed,  8 May 2024 19:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715197323;
	bh=ZvMxS/6Il7AG6FkDa3UhAvJRDgJpxkW07GOyJVCjJzw=;
	h=From:Date:Subject:To:Cc:From;
	b=p2BbLOLJa5SsDgF7PZaMXEQI/ySz8NTK8iq3COqHlnKHnh4FAVnRO2poJc4ARRRwx
	 XdlS3uvmOyYthMoQ0IwdR2RsviLY3Si8MPVVDkDZLT3siR6mVpAbzDPh7Lq1c03dog
	 qP/3jAkCM6abOoKrSREqXH7Oc0h54T32x0R/XHfucVaERG6LojlXU9saAWuKqQvMzy
	 BQCUTtw8E7pT+qlbWtKCxW16M2NtgzVQAmjvG3gy6GpDphONS+W623j6C9jlthoMvq
	 7Phq096qFOsNk6nuIzMAmE+DrwM/HrY1V3e4qOZFvdaGqOkkKs/bq9pH+/LsrMH3gl
	 em8adgRLdZFbg==
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so690025e9.3;
        Wed, 08 May 2024 12:42:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4IL9FJ5lmcq3Mp3wnzzVA1UO5137BoT+neWwKIn5IYqzV93gXFgZEE8yJOwBbd11KflDqNidI+DveIlg+hgGo/gIqplwHOJ1lKTn9wZsa0GVKY56WUlkcwMpaYOk/3b8nHRfJJQ0GDw==
X-Gm-Message-State: AOJu0Yyo96dWkIwl8bS+f7oPH3yZ0hNyQLDgANxZF/SzYwfkwhv1+t6M
	2uhojycaKFUgRLJebHuWImz4D9CEjTMLmUCSEpvp8rKmB9FbcL312R/UHYcYsKLtwnHByoLcH1t
	CIPVDpoDp5LoMCK5Cs/f1gfyoYyE=
X-Google-Smtp-Source: AGHT+IGzMqv4FDOrR5yP69QYi1649Z7yLH3EwLFqCDS69IVKUw6YvwnFFMRCPE9Tc5E/e8NwR7l/9RFnihhAAKq2pKA=
X-Received: by 2002:a05:600c:4587:b0:41e:a10:1347 with SMTP id
 5b1f17b1804b1-41f71cd4867mr27096675e9.20.1715197321590; Wed, 08 May 2024
 12:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Wed, 8 May 2024 12:41:48 -0700
X-Gmail-Original-Message-ID: <CAB=NE6V_TqhQ0cqSdnDg7AZZQ5ZqzgBJHuHkjKBK0x_buKsgeQ@mail.gmail.com>
Message-ID: <CAB=NE6V_TqhQ0cqSdnDg7AZZQ5ZqzgBJHuHkjKBK0x_buKsgeQ@mail.gmail.com>
Subject: XFS BoF at LSFMM
To: lsf-pc@lists.linux-foundation.org, xfs <linux-xfs@vger.kernel.org>
Cc: Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"

How about an XFS BoF at LSFMM? Would it be good to separate the BoF
for XFS and bcachefs so that folks who want to attend both can do so?
How about Wednesday 15:30? That would allow a full hour for bcachefs.

  Luis


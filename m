Return-Path: <linux-fsdevel+bounces-36124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A049DBFA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 08:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4441164C5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 07:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E267B157495;
	Fri, 29 Nov 2024 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="m71nhJFf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3601386DA
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732864228; cv=none; b=r6TCrltw8FEOFQv/82t6oDw4VRs4c1PJpymxc8U1ibJXirL5di8wQY6Sk+h2gaGFV9BEC46nzjKYgpZQKhcZjM1l3jPC4nWMvTE1Np9tf/VTLDgW/0XtOD2krzGnD+1e66KCi5NgUftqxgdZU84kRulbuDsONZWoPz5AgzCr1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732864228; c=relaxed/simple;
	bh=JEz0II3wPUIUF/fSqaCmDTV//sAnwzm12kigaIvKJMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZX8UzC18b/3XyooLS942ttxdqTcWMqAQ6gY/vbyCThYIZNBOjVbF+C88FO96QkLVNwER7z8+JF6fS9ea57ajjS4W9vOnRd4X9ADfXn8L2oZThsKivgCOvBkjlCZXBcM8mLYAu2AqBxVD5DIZ6kIDtLBzC09ANFQebRzuITU3mEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=m71nhJFf; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46695dd02e8so14835001cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 23:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1732864224; x=1733469024; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ldFcKDY051HIaSZokdZT8WNnme66AjUBwgdxm61ahfA=;
        b=m71nhJFficx66lSn7flq+4lOYYivkCQqk+kB4ORPD7KvOOHn6zUfRe6c+LIwH/aDf6
         DWN388q9LqDrCQyMTONScrkyr532f64SDgOHKxuxYu8Qcx94gUaSmzscZ4DYYV7M+Zw8
         HqUdObVW178FggxyVEmCbykpNjTCc8QTfsThk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732864224; x=1733469024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldFcKDY051HIaSZokdZT8WNnme66AjUBwgdxm61ahfA=;
        b=cgksl3yN8i6nHrHvZVu6yJdXdgLNr++3tdxrd0vok7N1HdfQgkKmihyHO6ESdBilmy
         VDet/E+7avBcG1QyEfa9QAWlxLOcwSrKYA1CAuD6AjzXg7wgeSos+UD712Y1ZywH47AU
         QUNmROSckWZ+vEYJfnLXyrsHC3fr4agXuE/btWL7zakFMXfHhYWuwcbD/CUOaCUJI1NU
         rPi0uQsAabg/PipzTELm+LjLV5OL5ISfc+95QuuAKaqWbg8yJ0B6EpgW6IjV0PWwq2V3
         LnPFNlJmiPmTdcMnbXDjEnX/qe+KFzBz/9uefRp9aGUSfIMyijhaYRc/Y6bsyjdkzQfv
         b2bw==
X-Forwarded-Encrypted: i=1; AJvYcCXJmRHzNdU5htCNnZwpSVMhSmADR/IIYnXEmOPpi0UEP8N0WDMdTsB3MhBUNQ5Sz5h8pPSi8y4yNEdkUKlb@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvUyfjm7iI6vsyS6daHhgPv8fukbyGbR8+FaJ7y0DwP7BamgR
	GW0DDksknPFUnEXM6aTKKmT5wWC/s1wuw3M9AwGJd14jTtCAd33F+sCm0HUlfJMDV9AbdBs2vxh
	/Wc5qdsT3dCf7QKMpPy84cMdIPry3KmaGCYI6ww==
X-Gm-Gg: ASbGncvETx+qyNewcMQv8OxK6TsVAq16EqYCqJFWIBuAJ/oN8dbBExbpa/9jgwCfQFc
	GAo6LIr+7hQZvq77UkNBS3BSfv6puuwIzvQ==
X-Google-Smtp-Source: AGHT+IH0Sd3pQYTKTVGdScb2/HSUzM3Ujrly8IxVM26kUOiWNoxlsQkfmYIPT59L0RqP87NWYDQCblDaLahnNU0S59U=
X-Received: by 2002:a05:622a:1801:b0:462:a7d1:8e19 with SMTP id
 d75a77b69052e-466b359cc6dmr167906631cf.13.1732864224215; Thu, 28 Nov 2024
 23:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128144002.42121-1-mszeredi@redhat.com> <20241128195738.GG3387508@ZenIV>
In-Reply-To: <20241128195738.GG3387508@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 29 Nov 2024 08:10:13 +0100
Message-ID: <CAJfpegvCHFwEf=sy56EPABv8BFVJA+HTjT26U_bOzHukwgBk5w@mail.gmail.com>
Subject: Re: [RFC PATCH] fanotify: notify on mount attach and detach
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 20:57, Al Viro <viro@zeniv.linux.org.uk> wrote:

> So... why is it not a DoS?

Certainly looks like one.  I intentionally didn't give too much
thought to the hook placement to be able to send out a quick proof of
concept patch.   Will move them outside of mount_lock.

Thanks,
Mikos


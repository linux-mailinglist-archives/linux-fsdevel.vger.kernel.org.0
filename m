Return-Path: <linux-fsdevel+bounces-36673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977C99E7954
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 20:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FFD2843C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 19:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F5D1D95B3;
	Fri,  6 Dec 2024 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaV7pbX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4575146A87
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515002; cv=none; b=D9CYSjFJw6RNEomag8zvCBb3OvxwnoIB/d2wO9ZhhjRTbywxhDYAFU0Yf68M+6Wg/T2GxCvspoX5wMzM/Ggpjs+OnOvn1g/B/39RwOdhxhLo+HQt+zhXb/hOt81Od9fLCLjWVMNDsdawx9C26AHT+9VY/wn3t+xnrR/qYa2V91A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515002; c=relaxed/simple;
	bh=pNjOPYWM1TYLihyXTxYzcibVvQ6WNslzkT+xOdBYGq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+coE33rEJJ3vKjYv/QqmBrJ5cL+4HMAh9Ekbz7em+ozKgdtiD1+9KQYwwNlZdRHYd9Sz7gkpHrLKyg0jM7yPS0kg0alqLVQipMfqyywMtxaJHXW9CaV8nEMKWI72gbZGwXT+q9pZGrnEP4mgp9+FSUAIQ1fQc1qi4z3yZZ3lGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaV7pbX7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-466847440a6so14508791cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 11:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733515000; x=1734119800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QKnFahh/HBNM5z51S0bL+ZEuCVFSeja8iGbg/DjrY6M=;
        b=jaV7pbX7sKuuP3vYypT0tZ10LquyLCH5qYcHM+3NzC08/frV1/GKfwqAkfDwK88nm4
         fxTvrZB7eXQvJLlIrdCGlzG3Nwo2MJpJRWIY8G5F61iw0DRMdMRRdJBRR1B+uO3j9blo
         LQXTkiC4/rLLr9AsNONQXqMfpZVh7rVo9MvFdxKAPKy/5NmUylHvN3TVuyk6vylYagrE
         X5/QFGeik34NBtSyNFQ1ahTSGSmrcOPbBESGcXqlmI/xDnVOA4eJ5i5LqUJSlQKC/FKn
         CB7CqfsackCgwn5IPGW6ONq2wRn+4/gXZSJDjqScT3ACecxBZtekQwPTYd18dQgWSpiB
         ka7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515000; x=1734119800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKnFahh/HBNM5z51S0bL+ZEuCVFSeja8iGbg/DjrY6M=;
        b=BSnF/W4RdTj+8z+xz/LuJd10oDUgOTDYp4v6K0JZ/BaLKyDBIXW3CubS+sr9kx0Vyy
         5FxyQTHyeu9ns6r4nctAe0U84XYqBOuB22Pp9dRUH7qo9pkOUXP84xO4AgbyIjQk+Fso
         OgpJJ7HD8MuYFfuvaTtCLBm6dw7w2VGmsqbOBKAjHey2dd1kOi0RjGrxn7LeFWPHO/OE
         87H0gZtgHzxXx09v0DZ4Me6wKjBrdTY7tpsu8c6UpMpSYNaGwl8UTsLxGMwDHErIiYRM
         2Adpxkt329VYninH5n+ExcI1YEPGCTLFpFCIT0EwWb2t8uixK08PoCM70yoDtGi6Pz+G
         LTgw==
X-Forwarded-Encrypted: i=1; AJvYcCXe9ZSxpcENFUfoqRgRklm9TNSDEhv2n/mEyTEH4e5JEAEQzH3t9ERyZkIoHQeUspDZ54/3JhVijPHAfuhJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9OqCLPU431s27BuzIKwviO9dKNOzXBxRJvtJ6q0Crpkicby1T
	v/YfeQSjHBrS5gTAFqvlAETtdKV//DslneQqX0ipTsLIqBCGHybeVl8DYiLNLBFRt2kfBk3c0vD
	VdIxhLESXNhPWZ/wxvohmETpXggs=
X-Gm-Gg: ASbGncsBdA/QAOcUB629cpHMZRB7AS5hZVg9+12Ik+tBPWG0EGDLqxUSYSquvvJoyU/
	eHKPAu/TlBS/N0NIG1/kLM0Rjc6FatVKc
X-Google-Smtp-Source: AGHT+IFPNBRMYq2uo710yde+RZB+J41Ex0GgrtsWcdNwQmxzcQUvnqI3rNDg3+UQJD9udzKl+/8FTOJJ8siz/7E2D5w=
X-Received: by 2002:a05:622a:19a2:b0:466:a763:257a with SMTP id
 d75a77b69052e-46734fcd62bmr56458211cf.54.1733514999756; Fri, 06 Dec 2024
 11:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com> <CAJnrk1Yc2VN-NZb4NfDNrvMmhP3AdioRoHOB0HxmyR_8aBNXRQ@mail.gmail.com>
In-Reply-To: <CAJnrk1Yc2VN-NZb4NfDNrvMmhP3AdioRoHOB0HxmyR_8aBNXRQ@mail.gmail.com>
From: Etienne <etmartin4313@gmail.com>
Date: Fri, 6 Dec 2024 14:56:28 -0500
Message-ID: <CAMHPp_Rk4ai0psCtodxb7pNsRQ5r1p7i2y635QzmRcVSxd3eBw@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, bschubert@ddn.com, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, kernel-team@meta.com, laoar.shao@gmail.com
Content-Type: text/plain; charset="UTF-8"

> > I tried this V9 patchset and realized that upon max_request_timeout the connection will be dropped irrespectively if the task is in D state or not. I guess this is expected behavior.
>
> Yes, the connection will be dropped regardless of what state the task is in.
Thanks for confirmation

>
> > To me the concerning aspect is when tasks are going in D state because of the consequence when running with hung_task_timeout_secs and hung_task_panic=1.
>
> Could you elaborate on this a bit more? When running with
> hung_task_timeout_secs and hung_task_panic=1, how does it cause the
> task to go into D state?

Sorry for the confusion. It doesn't cause tasks to go in D state.
What I meant is that I've been looking for a way to terminate tasks
stuck in D state because we have hung_task_panic=1 and this is causing
bad consequences when they trigger the hung task timer.

> > Here this timer may get queued and if echo 1 > /sys/fs/fuse/connections/'nn'/abort is done at more or less the same time over the same connection I'm wondering what will happen?
> > At least I think we may need timer_delete_sync() instead of timer_delete() in fuse_abort_conn() and potentially call it from the top of fuse_abort_conn() instead.
>
> I don't think this is an issue because there's still a reference on
> the "struct fuse_conn" when fuse_abort_conn() is called. The fuse_conn
> struct is freed in fuse_conn_put() when the last refcount is dropped,
> and in fuse_conn_put() there's this line
>
> if (fc->timeout.req_timeout)
>   timer_shutdown_sync(&fc->timeout.timer);
>
> that guarantees the timer is not queued / callback of timer is not
> running / cannot be rearmed.

Got it. I missed that last part in fuse_conn_put()
Thanks


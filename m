Return-Path: <linux-fsdevel+bounces-24689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D6F9431AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 16:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38A51F22129
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD8B1B3749;
	Wed, 31 Jul 2024 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="BSMn+6VP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6216D4CB
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434915; cv=none; b=ZeMscxaXZhuKD4Ixtol0McRkzPDtUx1XipbW+HmdrRf588rF7HJTlar6Mxo/E9BeXA6pVqmps6ELj9T/p59WuxkVTG1KY2bHxxJgURtsbTbFYms7b4OEsaph993gUbdqTIOZFSi6jGmljnOMGEcR2QhKWWC0kcjtoDxXer99fqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434915; c=relaxed/simple;
	bh=J5SiSatowZDOZhueocm/4JGajxjW30Ltk8zkSkH1Szo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ir+uE3QGZnjgWPU9ULZwTA8HJjXnDdoRYUMXdMekyxaFOV7UFgQUh7aVCKmb7NFhuOKY+Cz8Ep4kcinf9hPQylyga5gVL9b2A9I9AiCWc28qJ7JWXHU0NuHklKcJJwB6DvH9XELhHJIyrz1d6Pyerk+v4RKNdF1q3rTwHkDFn0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=BSMn+6VP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1dcc7bc05so360247985a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 07:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1722434912; x=1723039712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OmbqZ+SwBt9pWBiENqDvPp5IsdPjBdZOSucm6Q9PEz0=;
        b=BSMn+6VPwgDy5AwT+veSi9Krms5LvEOIwGgXWXEjTzx6caXE+SFLCXJx25YhtYTAPu
         KcP9Eydf8FME5M3LYu6kOTCd6zDwa+sKdRUyGGDnwoHLTAFuf/nn0hMhahG6hWL45Eub
         7+JQwHyrdMFTyISQVjF25JTRcE9whjyOrs8hjM/LLYcVDONGL59so6bqi44m+Poh61Gs
         jd2P1iA+BrHgqg0NHGbxGvURL0nFwGZtOJADqkQbmcJhTvpfiWnq9DdPkwRgrZMewKOm
         ht5rjF9Jp0zTt03AqVchuD8vswK9M0zDbMU7uiFIe09d1/e/XB4RiR/DFTpeO9dksOUy
         LL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722434912; x=1723039712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmbqZ+SwBt9pWBiENqDvPp5IsdPjBdZOSucm6Q9PEz0=;
        b=rmNVnzT5ABYBL7VVdxwcYAZMWFsEi5d0jyTC5vjZhFOwzVuZTWJ/dbObRT4OIH1maR
         ftXikzjj4CiEoQQvAxAIVUoC+BR8N5B9ySFE7BonC5RNB0yDQVW1ES+3M0BNdTklRHmG
         wYVCgy4SkWWyrx48aMVBiu92LLRLk0dIG0qgDSKHFhlKZwhO6c7RJwmHM5tzg4aiCwEJ
         cDd63Gjd8ghf1B2wqvXvrLl2DxSxCkwz3poKaTNUEvNwjtISotQoscpPPRjqRszUE5jy
         WWMBpx4Y8LTvnYALBsKb4eUiF0AAjDVGBW7GMveRaYr+Kp4fjXSsHKfwqZwCNtTuu9k1
         bv1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAg4zCZUZQKDaNy4JKIQ509aV2AFVjqPgpKWG8agMR6vPC/c9QfDcqX/FwRr9UJDx10PyKAYq2KlUUDZ8agsYNtz9cK8epJwD6EfRFNA==
X-Gm-Message-State: AOJu0YwBiyg8aOrUna/r/hFV/mb6rLtstfeCAoV1Jm3l3V1ebQx6XGGl
	c74+FJz7TrcC2Ao/vurIGAw14JhF3Nnyzp3g5mru1pfHEhDt9pXPbsWza4TjMw==
X-Google-Smtp-Source: AGHT+IE6kPGJyplTmL+CdLHYVHoAqc9Zp1sYnDW3Lj3rFha6QTxDYm53FQkQABVQPDmkoe6eOIvPbg==
X-Received: by 2002:a05:620a:4143:b0:79f:10e6:2ee with SMTP id af79cd13be357-7a1e5260140mr1740167585a.41.1722434912481;
        Wed, 31 Jul 2024 07:08:32 -0700 (PDT)
Received: from rowland.harvard.edu (iolanthe.rowland.org. [192.131.102.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1fdd2f90csm210796285a.24.2024.07.31.07.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 07:08:32 -0700 (PDT)
Date: Wed, 31 Jul 2024 10:08:29 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, davem@davemloft.net,
	dvyukov@google.com, elver@google.com, glider@google.com,
	gregkh@linuxfoundation.org, hdanton@sina.com, jhs@mojatatu.com,
	kasan-dev@googlegroups.com, keescook@chromium.org, kuba@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-usb@vger.kernel.org, luyun@kylinos.cn,
	netdev@vger.kernel.org, pctammela@mojatatu.com, rafael@kernel.org,
	syzkaller-bugs@googlegroups.com, victor@mojatatu.com,
	vinicius.gomes@intel.com, viro@zeniv.linux.org.uk,
	vladimir.oltean@nxp.com
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in __run_timer_base
Message-ID: <3eb71b17-33c3-42fa-86e6-459c3bfdbf29@rowland.harvard.edu>
References: <00000000000022a23c061604edb3@google.com>
 <000000000000d61bb8061e89caa5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d61bb8061e89caa5@google.com>

On Wed, Jul 31, 2024 at 04:57:02AM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 22f00812862564b314784167a89f27b444f82a46
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Fri Jun 14 01:30:43 2024 +0000
> 
>     USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f906bd980000
> start commit:   89be4025b0db Merge tag '6.10-rc1-smb3-client-fixes' of git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
> dashboard link: https://syzkaller.appspot.com/bug?extid=1acbadd9f48eeeacda29
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145ed3fc980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c1541c980000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 

#syz fix: USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


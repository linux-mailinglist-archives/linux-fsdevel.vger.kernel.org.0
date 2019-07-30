Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD727B51C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 23:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfG3Vig (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 17:38:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34076 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfG3Vig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:38:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id l12so49059588oil.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2019 14:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5JOOn7SBmn+BXEukedT9HDXQ6WS/r4bECASKDsfPTc=;
        b=wPargsCx1nCKwYgN+UmNJ+Ig2yIDukdOFYcafHAoe3HixxhzXwRMveW8WJbYjiLDVB
         XbzprVIA35u37LGeX54iP4ILaKrn2ZhsHJ7HWatfCu+Dy3AK04gYp0qsDNO5JINxbU66
         793vBLMC/2q9GjCzIncgSDaS52sZ95bS4q3yUIBVFG0BqK7kBkiiL0rUkTy1gy785b/G
         HixoGYJN0KZsmAs7IKt+3EffEecPzG3ht9NV6iRwONmKHhzWMdcK5ojktOyBien+IE2z
         ZnpdPMHhrkvdWxeuLBaHFjco1kw0VqWIzURD3Kv3X0Zi1Xvi85u1GhDy0eXKzpdjXw/K
         RMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5JOOn7SBmn+BXEukedT9HDXQ6WS/r4bECASKDsfPTc=;
        b=TL1/V+XJnPj7ckY6TBLWW7mjz4cUelvbByzPAiDQcwZWjk6zkOy1SG6w8too7I20cA
         3aphpHbS8ayUXn0M6vM5W3Oy4mjHnAskbm4/TibcXxWVk1J19bAro3AXyZk1dVT0WY89
         b1kbYm2GHHaLMn7kVl1xgmV+3ekpg5sUGlMffCCj1Zm7j142Qu/V4GvzcuaiLTnIzFlm
         beDH8L+kD8u2O8RoQAp0kO6cWmh7ZhleG01nU+vbFDj7hK0TSbHWGw1XIKW9x67dlyOz
         33k2sjWablzy94UHkB/ev9zt6wyGCYo+XNNrQ90PP3KjphJj+o7Rmh9Obh1Xl8b85twb
         8+Fg==
X-Gm-Message-State: APjAAAU7q7ywG71Suw3z18DDsi7lu5hE8W9NxrMBZjNFO30jNQ2FjptC
        HaVYl3y2ufRirWTMzpo/ehZKJGpe26FeKwvBxnL54VFd
X-Google-Smtp-Source: APXvYqz/vebOGKyx5iJtOjMRLpWnJO3JxlqPxCgJzVvyZc/nI/IYK9bwftHIvxiV8iym6ilmxvWFcSB3C9ypYO/5uNs=
X-Received: by 2002:aca:d80a:: with SMTP id p10mr58049607oig.105.1564522715513;
 Tue, 30 Jul 2019 14:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190730113708.14660-1-pagupta@redhat.com> <2030283543.5419072.1564486701158.JavaMail.zimbra@redhat.com>
 <20190730190737.GA14873@redhat.com>
In-Reply-To: <20190730190737.GA14873@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Jul 2019 14:38:24 -0700
Message-ID: <CAPcyv4i10K3QdSwa3EF9t8pS-QrB9YcBEMy49N1PnYQzCkBJCw@mail.gmail.com>
Subject: Re: dm: fix dax_dev NULL dereference
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Pankaj Gupta <pagupta@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>, jencce.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 30, 2019 at 12:07 PM Mike Snitzer <snitzer@redhat.com> wrote:
>
> I staged the fix (which I tweaked) here:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.3&id=95b9ebb78c4c733f8912a195fbd0bc19960e726e

Thanks for picking this up Mike, but I'd prefer to just teach
dax_synchronous() to return false if the passed in dax_dev is NULL.
Thoughts?

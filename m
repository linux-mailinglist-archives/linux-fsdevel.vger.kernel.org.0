Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA1050605
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 11:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfFXJp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 05:45:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35496 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfFXJp1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:45:27 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfLX6-00045j-BR; Mon, 24 Jun 2019 11:45:04 +0200
Date:   Mon, 24 Jun 2019 11:45:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
cc:     corbet@lwn.net, mcgrof@kernel.org,
        Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org,
        manfred@colorfullife.com, jwilk@jwilk.net, dvyukov@google.com,
        feng.tang@intel.com, sunilmut@microsoft.com,
        quentin.perret@arm.com, linux@leemhuis.info, alex.popov@linux.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "wangxiaogang (F)" <wangxiaogang3@huawei.com>,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, tedheadster@gmail.com,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH next] softirq: enable MAX_SOFTIRQ_TIME tuning with sysctl
 max_softirq_time_usecs
In-Reply-To: <0099726a-ead3-bdbe-4c66-c8adc9a4f11b@huawei.com>
Message-ID: <alpine.DEB.2.21.1906241141370.32342@nanos.tec.linutronix.de>
References: <f274f85a-bbb6-3e32-b293-1d5d7f27a98f@huawei.com> <alpine.DEB.2.21.1906231820470.32342@nanos.tec.linutronix.de> <0099726a-ead3-bdbe-4c66-c8adc9a4f11b@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-687753982-1561369504=:32342"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-687753982-1561369504=:32342
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8BIT

Zhiqiang,

On Mon, 24 Jun 2019, Zhiqiang Liu wrote:
> ÔÚ 2019/6/24 0:38, Thomas Gleixner Ð´µÀ:
> > If we keep it jiffies based, then microseconds do not make any sense. They
> > just give a false sense of controlability.
> > 
> > Keep also in mind that with jiffies the accuracy depends also on the
> > distance to the next tick when 'end' is evaluated. The next tick might be
> > imminent.
> > 
> > That's all information which needs to be in the documentation.
> > 
> 
> Thanks again for your detailed advice.
> As your said, the max_softirq_time_usecs setting without explaining the
> relationship with CONFIG_HZ will give a false sense of controlability. And
> the time accuracy of jiffies will result in a certain difference between the
> max_softirq_time_usecs set value and the actual value, which is in one jiffies
> range.
> 
> I will add these infomation in the sysctl documentation and changelog in v2 patch.

Please make the sysctl milliseconds based. That's the closest approximation
of useful units for this. This still has the same issues as explained
before but it's not off by 3 orders of magitude anymore.

Thanks,

	tglx
--8323329-687753982-1561369504=:32342--

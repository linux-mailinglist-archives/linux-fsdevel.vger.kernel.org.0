Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1F4B2C59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 19:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347914AbiBKSC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 13:02:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbiBKSCy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:02:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF024CD5;
        Fri, 11 Feb 2022 10:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xTHswMICZWUkB9UKsb5f4hDzHGeX5BCkVihfhWe2wlg=; b=GY+749fQoBbvRjbQv1NijyEK0U
        58LqzH8sJvj6fV/p2d7waAxy3mmQobPAxvcmxJH7CO2KtYFw5jQMcUNY2hRjd5G7iPWbec8HdkVi+
        TAduDCGjBc/9hDpikdA3gsPCK3YJuAe1fNU1o/1uYyPamr89tF84BICslflff8s/ANMiUT9sw5u1D
        Q+WUkLakT0PZ3He2e8DpQgwgLoB0ymNOpgdoL+7lHJHPj8cqfN66ttgv63DSiZCljl1Gii5znhJLV
        SuXMAj6cF4R1E8ZJdji+9ispziUMII80Mi3DeKw8ucvO6Y2yqJ1bJi6FcmXHO7SzBzbA6Jm8rECSR
        X4xIjMBQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIaFt-008KoS-VK; Fri, 11 Feb 2022 18:02:49 +0000
Date:   Fri, 11 Feb 2022 10:02:49 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] Splat in __register_sysctl_table() in next-20220210
Message-ID: <YgakyWEJvsUvaAtW@bombadil.infradead.org>
References: <20220211170455.GA1328576@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211170455.GA1328576@paulmck-ThinkPad-P17-Gen-1>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 11, 2022 at 09:04:55AM -0800, Paul E. McKenney wrote:
> Hello!
> 
> I just wanted to be the 20th person to report the below splat in
> init_fs_stat_sysctls() during boot.  ;-)
> 
> It happens on all rcutorture scenarios, for whatever that might be
> worth.

It should be fixed on today's linux-next, see this discussion:

https://lore.kernel.org/linux-ext4/20220210091648.w5wie3llqri5kfw3@quack3.lan/T/#mfc3683a68aaec8595cd5f26e138453132a3e1d43

Essentially there was a fix which Andrew merged. The Linus merged it.
But linux-next carried Andrew's fix too, so there was a double
registration.

Please let me know if you still see the issue on next-20220211 !

  Luis

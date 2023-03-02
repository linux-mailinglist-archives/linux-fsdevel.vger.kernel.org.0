Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033656A79A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 03:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCBCrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 21:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCBCrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:47:12 -0500
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2FE311EB;
        Wed,  1 Mar 2023 18:47:06 -0800 (PST)
X-QQ-mid: bizesmtp91t1677725134tsr3oo2o
Received: from [10.4.23.76] ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 02 Mar 2023 10:45:32 +0800 (CST)
X-QQ-SSF: 01400000000000I0Z000000A0000000
X-QQ-FEAT: x6NscV/x+aPCnalsSZoqelLTHK5XG8APLs180rHlvZFVedlbmOrDH7seBscTU
        Xogcz4AKmbhV3ZhKi+Sd9aLyoN5ShqlvDDDw+9YBCerOrBKcOEfjH8gX895MLcwa4Pv8kWY
        C/FmTvXT1mjIM1thT//wVhxXRjJLo5ZlbjuKrO58yAEJCVZGGlZmo7uwR3KU7EpFIidNL2B
        +rIm7cu3MfrGB1AORBWUNGWpLv6B3ZTMX2xshqcAIEP+FqBcA553GNDy1FVA9tMMcEH6iNC
        lVEPARjGcCR/sjmAa6LUopIcd4/mVZ4UhRvkC8v8ViywIMFLCzWjAYApYd1uecCod3GDv4t
        sXGErUG+3QYv2bQyk202MZSApJOwjwbWGj+RUqNwoa0hbPfr6lUq//pOo60EZxQ7Iu5oO2K
X-QQ-GoodBg: 1
Message-ID: <541B117370C84093+1a6c9c3b-20a0-cbb5-56e4-5ab0f5e42f03@uniontech.com>
Date:   Thu, 2 Mar 2023 10:45:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/2] fs/proc: optimize register ctl_tables
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Peng Zhang <zhangpeng362@huawei.com>,
        Joel Granados <j.granados@samsung.com>
Cc:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        willy@infradead.org, kbuild-all@lists.01.org,
        nixiaoming@huawei.com, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220304112341.19528-1-tangmeng@uniontech.com>
 <202203081905.IbWENTfU-lkp@intel.com>
 <Y7xWUQQIJYLMk5fO@bombadil.infradead.org>
 <Y8iKjJYMFRSthxzn@bombadil.infradead.org>
 <Y//4B2Bw4O2umKgW@bombadil.infradead.org>
From:   Meng Tang <tangmeng@uniontech.com>
In-Reply-To: <Y//4B2Bw4O2umKgW@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2023/3/2 09:12, Luis Chamberlain wrot
> 
> I've taken the time to rebase this but I'm not a big fan of how fragile
> it is, you can easily forget to do the proper accounting or bailing out.
> 
> Upon looking at all this it reminded me tons of times Eric has
> said a few calls are just compatibility wrappers, and otherwise they are
> deprecated. Ie, they exist just to old users but we should have new
> users move on to the new helpers. When / if we can move the older ones

When a user registers sysctl, the entry is register_sysctl. In order to 
be compatible with the previous method, I added the following statement:

+#define register_sysctl(path, table) register_sysctl_with_num(path, 
table, ARRAY_SIZE(table))

On this basis, we can provide both register_sysctl and 
register_sysctl_with_num.

> away that'd be great. Knowing that simplifies the use-cases we have to
> address for this case too.

We need to modify the helper description information, but this does not 
affect the compatible use of the current old method and the new method now.

> 
> So I phased out completely register_sysctl_paths() and then started to
> work on register_sysctl_table(). I didn't complete phasing out
> register_sysctl_table() but with a bit of patience and looking at the
> few last examples I did I think we can quickly phase it out with coccinelle.
> Here's where I'm at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing
> 
> On top of that I've rebased your patches but I'm not confident in them
> so I just put this out here in case others want to work on it:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-testing-opt
> 
> What I think we should do first instead is do a non-functional change
> which transforms all loops to list_for_each_table_entry() and then
> we can consider using the bail out *within* the list_for_each_table_entry()
> macro itself.
> 
> That would solve the first part -- the fragile odd checks to bail out
> early.  But not the odd accounting we have to do at times. So it begs
> the question if we can instead deprecate register_sysctl_table() and
> then have a counter for us at all times. Also maybe an even simpler
> alternative may just be to see to have the nr_entries be inferred with
> ARRAY_SIZE() if count_subheaders() == 1? I haven't looked into that yet.
> 

Do you want to know here is whether it is possible to accurately 
calculate nr_entries if entry->child is established?

This is a problem. In the current patch, count_subheaders() still needs 
to get the ARRAY_SIZE() of the table. If there is a child, I still use 
list_for_each_table_entry(entry, child_table) to deal with it.

That is, when calling count_subheaders():
1)Specify the table ARRAY_SIZE(), then count_subheaders(table, 
ARRAY_SIZE(table));
2)Unknown table ARRAY_SIZE(), then count_subheaders(table, 0).
Use list_for_each_table_entry(entry, child_table), end traversal until 
the entry->procname is NULL.

This results in the child_table still needing to end with a “[]”. But I 
haven't thought of a better way to handle this in this case.

>    Luis
> 

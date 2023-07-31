Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30EE768EB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 09:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGaH3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 03:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjGaH1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:27:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCC226AA
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 00:24:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-317980c4236so1000795f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 00:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690788243; x=1691393043;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1r5d1/XxWBiA5/zsSJMx3Nmv7ohq+5hAtLvQYL/x44=;
        b=aIslbuwc6yz4kCme29YdtC9yCLvzIO/B8glHoWWmB6TwCAz6TzOqf19hkImoopYIjR
         myTS7qB+/13KhevnmVlx2tZWZEK9XNjXzqZKPZ+5al27JODhTzW5U9i5GFofSmcwzlBO
         7FSr4A7oX+jpkc3FKFrbUHVS59mUI//5NvSXAxBOfC1xQhyedDHDTC60Dfebh+yF1WsO
         OEUm5dHJI3a1gvxh1z8qv5HtHz90ve5eN7dEaSB60HqU4NbDyu8sVNc+S9ZDVHIRf/8S
         6ycp8CeDt+CAR4XYlDm7Sezj+kNPrkfGAoD4xJI4D7pmt22OtVGBwwqPWVfAZxJDX1MC
         ugzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690788243; x=1691393043;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1r5d1/XxWBiA5/zsSJMx3Nmv7ohq+5hAtLvQYL/x44=;
        b=TBqMpHTgMmS3HE3us+RncKLQSGPwOfDrjXTbzTAw1p9y8XSuzFXtMO+smMO6mBkzwl
         qO4rMFH0RqT0L3hAa2JETCdiugrelddD8jYE0lc5844YjRn1UlW3UPbPqK3iI5EttLrf
         UMIfLumEopgYjcE7u5fMMLWGym60ZhUP3+vxSbHJZu9xJIRNsx/k+r80hC1wDeyTGCvm
         pBY5z91clAlf0OPgvr58IaN947zbvoTTWVM9qvy7GLH7h4ZAGtMUMYTzbH/Myve9vaND
         QsjkQuaxHmlhqNpAk1LATM+AzqWFkDOJvbT+Tos/KKOVtrxe7AJ5tlzgjdkMZDn1Md+l
         zFbw==
X-Gm-Message-State: ABy/qLZe9WPzTmVneBwcqyHmJDihkGfOUgBswjoR6v5UMJCahBtzoUU7
        l4K2OY9uWvUO6tr5OxC8iB2dS+iKmWbVsP2Vjl0=
X-Google-Smtp-Source: APBJJlFiBmp9cG5D0bS6GcYtSs/dVHGh6Cd2QOAzc9t5r/efclTGq4QImsFsfew8Jg9iFM4BTHzh9Q==
X-Received: by 2002:a5d:508c:0:b0:317:7eec:5e9d with SMTP id a12-20020a5d508c000000b003177eec5e9dmr5480056wrt.16.1690788243277;
        Mon, 31 Jul 2023 00:24:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d604a000000b0031758e7ba6dsm12096190wrt.40.2023.07.31.00.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:24:03 -0700 (PDT)
Date:   Mon, 31 Jul 2023 09:34:45 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     zhangpeng.00@bytedance.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] maple_tree: make mas_validate_gaps() to check metadata
Message-ID: <757b8578-63ae-49cd-8b25-d0abb91ca996@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Peng Zhang,

This is a semi-automatic email about new static checker warnings.

The patch d126b5d9410f: "maple_tree: make mas_validate_gaps() to
check metadata" from Jul 11, 2023, leads to the following Smatch
complaint:

    tools/testing/radix-tree/../../../lib/maple_tree.c:6989 mas_validate_gaps()
    warn: variable dereferenced before check 'gaps' (see line 6983)

tools/testing/radix-tree/../../../lib/maple_tree.c
  6982	
  6983			if (gaps[offset] != max_gap) {
                            ^^^^^
Dereferenced.

  6984				pr_err("gap %p[%u] is not the largest gap %lu\n",
  6985				       node, offset, max_gap);
  6986				MT_BUG_ON(mas->tree, 1);
  6987			}
  6988	
  6989			MT_BUG_ON(mas->tree, !gaps);
                                             ^^^^^
Checked too late.  This is pointless as well.  Just delete this line.

  6990			for (i++ ; i < mt_slot_count(mte); i++) {
  6991				if (gaps[i] != 0) {

regards,
dan carpenter

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8BA6BAA65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 09:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjCOIFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 04:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjCOIFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:05:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF2283EF;
        Wed, 15 Mar 2023 01:05:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD2A061BD4;
        Wed, 15 Mar 2023 08:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCA3C433EF;
        Wed, 15 Mar 2023 08:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678867533;
        bh=618xVakUuQY56VYlwblOZrd2g51QvZP/REjgIIwHOZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTqQl28wKHaYHKVlT5GZdQUWOM6vJdRPU3nlEVrpMsHcNM5OMi4g4LQ0+6qvPVaoB
         5sveWtu5mD6I7KJWSgysqP0O++CFbbAlStkY/3+QAQzCvbwAa+F+SFHkeEGX/jdE8I
         MbszItbAgjEaF7ClWVqNgXVk3Epwwsldehu8cqJbioqnJAD5JE6ttI3hbzCsztkzz6
         vQg792V5Ipi3iftTVD8MgecuAcr2Qg1h4riKRJp5xA2Iaowa+ZJifG5uR2o9vdSwMV
         8z4N0PocO2+eRK7mxS3bXDCm8UFtjIuQJ5eUuyvEyLu7H7vTpZ091LQUCaUyqE9y6y
         jWutp9CTBy9EA==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v1 1/1] fs/namespace: fnic: Switch to use %ptTd
Date:   Wed, 15 Mar 2023 09:05:07 +0100
Message-Id: <167886710880.1081057.9449101039224999346.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230314150906.52318-1-andriy.shevchenko@linux.intel.com>
References: <20230314150906.52318-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=554; i=brauner@kernel.org; h=from:subject:message-id; bh=470UWTI0/anR7TZBGfhRKWDxs9zZzmvJgntL5Gb9AJw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQIVi8q2bOcvTJH8vfqU/uvZ52ofDxtVXV5DN+saSflPSsv CV6c3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRFWKMDK+3TuZ4bNP2aeOXwsDPe+ d9e6UaWLe9X71s8dbdh0P+Wh1n+Ctg67h6W7ZE5Aa9/9F7NvbnPld623DO1+Tm8sM73eunFjACAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner (Microsoft) <brauner@kernel.org>


On Tue, 14 Mar 2023 17:09:06 +0200, Andy Shevchenko wrote:
> Use %ptTd instead of open-coded variant to print contents
> of time64_t type in human readable form.
> 
> 

Ok, looking at lib/vsprintf.c

pointer(t)
-> time_and_date(T)
   -> time64_str()
      -> time64_to_tm()
      -> rtc_str(d)
	 -> date_str()

ends up with the same helper and four digits for the year so this seems
like a good cleanup. Thanks!

tree: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
branch: fs.misc
[1/1] fs/namespace: fnic: Switch to use %ptTd
      commit: 74e60b8b2f0fe3702710e648a31725ee8224dbdf

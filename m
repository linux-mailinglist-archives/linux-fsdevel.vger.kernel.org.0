Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1124C921C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 18:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbiCARpd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 12:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiCARpc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:45:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042032BD6;
        Tue,  1 Mar 2022 09:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x8QboE68qufGVCeh7eGFRudjtwH2eRrn2yzIYOD5Vgw=; b=c+eqLUh4cgb5zqr11iFm9AZnmi
        Az+zXe+HI8JwYuwddDIEUrK+6pj89VqZ1zXyDWCxMXCqgukYtTSbZ6vZcSYc+w5pTSSfcBc+jAZYF
        VkjhXX3c63bV892yWwICRDsLtO8mae1whZyrP+gdP7PklZzVviEmf+ux3H8d0KQ20ptp+nC7VKXVu
        OAt2wpQdQ0ce47qSwj54FTZ7C5udFJ8usFEcEO59Uu8WCY2ZKg4lUW8gYEDh783WnEmNftT6npfTD
        6eyqy94I8K5j3NL75Ayjji3npsZ0p29/YReuXtVRXgcJH72TbDwrbCrK6Q/tB6YA0pyC41bS3dj2z
        O9JxlSrQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP6Y5-0006Vm-SA; Tue, 01 Mar 2022 17:44:33 +0000
Date:   Tue, 1 Mar 2022 09:44:33 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Meng Tang <tangmeng@uniontech.com>
Cc:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        willy@infradead.org, nixiaoming@huawei.com, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs/proc: optimize exactly register one ctl_table
Message-ID: <Yh5bgYQM9a0ox95a@bombadil.infradead.org>
References: <20220301115341.30101-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301115341.30101-1-tangmeng@uniontech.com>
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

On Tue, Mar 01, 2022 at 07:53:40PM +0800, Meng Tang wrote:
> Sysctls are being moved out of kernel/sysctl.c and out to
> their own respective subsystems / users to help with easier
> maintance and avoid merge conflicts. But when we move just
> one entry and to its own new file the last entry for this
> new file must be empty, so we are essentialy bloating the
> kernel one extra empty entry per each newly moved sysctl.
> 
> To help with this, this adds support for registering just
> one ctl_table, therefore not bloating the kernel when we
> move a single ctl_table to its own file.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Meng Tang <tangmeng@uniontech.com>

Please extend the commit log to justify why we have to add
so much code, you mentioned it to me before, now just please
write that in the commit log.

Can you really not add helpers first so that these helpers
are used by both paths?

  Luis

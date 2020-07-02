Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3612212B6C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 19:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgGBRnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 13:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgGBRnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:43:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F0DC08C5C1;
        Thu,  2 Jul 2020 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c/ti3Um2rPtpXRIbW8ekfcfzcaaYCWd/840Frp0eP3o=; b=s2m3Az4ylcJFcwqyRY0E7W7bHu
        0LB8UEJflQmqt3eVWI+VA7JnS1krSA4llJDvzFFTEk0BEZgcTEcr9bibqZ+pbejTQwKc2ieHeoWt7
        xeMRWwCGaeSMnE5sAjqgoK9zk3BdbHrEy9/7Diuu5/iOs7OnGIfos1WYU2QKB2lbFbyUFPpuuuVWW
        TGraCLbetLk06bwIQElLtZCouwg2Giaa9r5nlJ4IzQEkW86053fZabVt2ZIpa3FbY6KsZ6ZAS1Ytw
        MKbmaxBPDVBW01KR4p9CxtuWqP4nt/10bwIelpfgJ63o9ZPlZ9G+sOtQvXd2U+XT4fGXTvYGuk0BA
        tfPmYLrw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jr3FS-0004Pj-Hp; Thu, 02 Jul 2020 17:43:46 +0000
Date:   Thu, 2 Jul 2020 18:43:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     yang che <chey84736@gmail.com>
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] hung_task:add detecting task in D state milliseconds
 timeout
Message-ID: <20200702174346.GB25523@casper.infradead.org>
References: <1593698893-6371-1-git-send-email-chey84736@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593698893-6371-1-git-send-email-chey84736@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 02, 2020 at 10:08:13PM +0800, yang che wrote:
> current hung_task_check_interval_secs and hung_task_timeout_secs
> only supports seconds.in some cases,the TASK_UNINTERRUPTIBLE state
> takes less than 1 second.The task of the graphical interface,
> the unterruptible state lasts for hundreds of milliseconds
> will cause the interface to freeze

The primary problem I see with this patch is that writing to the
millisecond file silently overrides the setting in the seconds file.
If you end up redoing this patch, there needs to be one variable which
is scaled when reading/writing the seconds file.

Taking a step back though, I think this is the wrong tool for the job.
I'm pretty sure KernelShark will do what you want without any kernel
modifications.


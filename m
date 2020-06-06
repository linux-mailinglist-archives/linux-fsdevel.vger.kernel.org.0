Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0539A1F0469
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 05:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgFFDUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 23:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgFFDUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 23:20:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CE4C08C5C2;
        Fri,  5 Jun 2020 20:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QCHbUkMYkrQJAPIqPlZ6VLNz3QmvlT+5Bsoz5d+kZkc=; b=HrDnOjP8lxTV2gp0+5S/V/+6Fe
        TJRoS3b62IqjQPH+Zb5/opZi+c4jc1QX24zhotF/L58RfchUFUuIGkNIlD9CbsM98qcbucS/ae8bB
        wMiWijV5Dl1Cpo3BzYy6ptUO5/P8TVIg7LXzYl7GTSLgsP9bSReADMpSbfCCf+8sFx/j92lJhM870
        +2YkvOm2FukwHVomLONhTQdt7rzMaK8wCbonT+O+IbtaVvC9HBtlRbGpCskkxDG+iR6N7fKSJzAfa
        Df6OTAVzzn2VTbeklQUgl8LO6FiQPsUBExeD1fuZHBrmv8RRRxtKy7MUbpguf6N/UtXwTMlkil0lB
        B59V0GAQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhPNT-0001pB-IT; Sat, 06 Jun 2020 03:20:11 +0000
Date:   Fri, 5 Jun 2020 20:20:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 1/8] fs: introduce kernel_pread_file* support
Message-ID: <20200606032011.GM19604@bombadil.infradead.org>
References: <20200605225959.12424-1-scott.branden@broadcom.com>
 <20200605225959.12424-2-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605225959.12424-2-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 03:59:52PM -0700, Scott Branden wrote:
> -int kernel_read_file(struct file *file, void **buf, loff_t *size,
> -		     loff_t max_size, enum kernel_read_file_id id)
> -{
> -	loff_t i_size, pos;
> +int kernel_pread_file(struct file *file, void **buf, loff_t *size,
> +		      loff_t pos, loff_t max_size,
> +		      enum kernel_pread_opt opt,
> +		      enum kernel_read_file_id id)

What is this 'kernel_pread_opt' foolishness?  Why not just pass in
~0UL as max_size if you want the entire file?

> -int kernel_read_file_from_path_initns(const char *path, void **buf,
> -				      loff_t *size, loff_t max_size,
> -				      enum kernel_read_file_id id)
> +extern int kernel_pread_file_from_path_initns(const char *path, void **buf,

extern?  really?  i'm shocked gcc doesn't vomit on that.


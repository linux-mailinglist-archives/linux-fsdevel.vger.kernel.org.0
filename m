Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCB81F3E4D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 16:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgFIOev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 10:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgFIOev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:34:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240C7C05BD1E;
        Tue,  9 Jun 2020 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BS61t3scD5rhsvldmGOJtyXVG6rDl8HEmiFZUjqsT1Q=; b=pFZbRjVutesuWvEsLEcOIckCTU
        B3HEtPGVpCN39H/vjxliXrmai3D//DgWvJMqaAaECUbY+uGMZ6/JoDe8HSpPKCIOxjdSsdO01gL4k
        jOfpF4lX6pW0QRPLyuOg22AAoBgA/FbpiiAOEc6nvbB1s1puwqnevV0HVIEy8unMbIITqwStbo958
        ORwKmICUrKdJ9Jpq/dlDO2GdCh36CSzheEAvMA4TxREBhMXFw8Dc31l+wFd++VFwgYc2Ytzeuu8FI
        3Xhapr9ybl4wIdCXPbVFVt5XN4bcA0++9e/Y7RYBFDK6bTxa5Fju3SlXupYEV1qkJZRkRZmY0V66L
        gazISSMA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jifKv-0008Vl-NS; Tue, 09 Jun 2020 14:34:45 +0000
Date:   Tue, 9 Jun 2020 07:34:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
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
Subject: Re: [PATCH v7 2/8] firmware: add offset to request_firmware_into_buf
Message-ID: <20200609143445.GD19604@bombadil.infradead.org>
References: <20200606050458.17281-1-scott.branden@broadcom.com>
 <20200606050458.17281-3-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200606050458.17281-3-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 10:04:52PM -0700, Scott Branden wrote:
>  static struct fw_priv *__allocate_fw_priv(const char *fw_name,
>  					  struct firmware_cache *fwc,
> -					  void *dbuf, size_t size)
> +					  void *dbuf, size_t size,
> +					  size_t offset,
> +					  enum kernel_pread_opt opt)
>  {

Your types are screwed up.  size_t is the size of something in memory.
loff_t is an offset in a file.  This should be an loff_t.  One of the
other patches has the opposite problem.

(this is kind of a minor problem compared to all the complexity
problems, but it's worth mentioning)

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2461D1AF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 18:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389532AbgEMQYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 12:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732380AbgEMQYD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 12:24:03 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00E8D20659;
        Wed, 13 May 2020 16:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589387042;
        bh=GMIEwlaUuMOKi5AkDYUqDh+tZ9JXGeSF/BENEVLdelE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O2CCNQtPLWuis6Iyzz3t9LE9/0N1orztrF73b2GHGrbexfrSZMT8U1JojVtMomoti
         4IWbO2zbjaT+y5cJm/QTf5h8Q0wwikUv/jNNnCpLz84UNFT4gDGcQZaIiYJsKfrFCx
         p/BF5chqdi5380TQ6UASs7NhMo537xeK2eTcgF54=
Message-ID: <1589387039.5098.147.camel@kernel.org>
Subject: Re: [PATCH v5 0/7] firmware: add partial read support in
 request_firmware_into_buf
From:   Mimi Zohar <zohar@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Date:   Wed, 13 May 2020 12:23:59 -0400
In-Reply-To: <20200508002739.19360-1-scott.branden@broadcom.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Scott,

On Thu, 2020-05-07 at 17:27 -0700, Scott Branden wrote:
> Please consider this version series ready for upstream acceptance.
> 
> This patch series adds partial read support in request_firmware_into_buf.
> In order to accept the enhanced API it has been requested that kernel
> selftests and upstreamed driver utilize the API enhancement and so
> are included in this patch series.
> 
> Also in this patch series is the addition of a new Broadcom VK driver
> utilizing the new request_firmware_into_buf enhanced API.

Up to now, the firmware blob was read into memory allowing IMA to
verify the file signature.  With this change, ima_post_read_file()
will not be able to verify the file signature.

(I don't think any of the other LSMs are on this hook, but you might
want to Cc the LSM or integrity mailing list.)

Mimi

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECC02EC6F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 00:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbhAFXj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 18:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbhAFXj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:39:29 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98C7C061786
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jan 2021 15:38:48 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id iq13so286139pjb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 15:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zo+uooqajJkVIc//qGbLq5a2/tbMq8FCHMG3Hgw2MPg=;
        b=EZN7MpBxbYHR9Lh0ewX4mZiq4ydtxnT0egjcjk7gNEwYb/IGUVMbHIxmyc7rXvP/ju
         5YpiG66ya+lrQwzp/2X4r/USBF2Xxkn5nYTwZteODtbSYNeKDwex4LiC/CMuVeHtcui/
         dTv7Ee789uT/X/ekZXgf2EBCsb3cXImFuV0HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zo+uooqajJkVIc//qGbLq5a2/tbMq8FCHMG3Hgw2MPg=;
        b=Uet9kqZwGaxi79qwhSAK5JjExEMqa4fZPbz8NoXuGRxtKAAHbh4cllRkFXbaBCa2ZI
         j4HrMTZ0dAbXbQxad53pzx/hL7reqEemdnZ8oOEEcypF8LuWyza0TWT/SM1VzOZTYypy
         rFlS1hQ6ewEi9eXBdgvMejEaW7P7Mh+p7Lzo4WqY4duCeg+krL0GEGLO16gSu5hm0qMk
         gb0EC/SCxCUeYfj166xXUdO1Z9v1nG3FBaPp7+xhK9Gb6X9RzYf8aKFSELZPQGm2x61t
         ygoMZKvCEwx8kPqTlUEw9ZEwFcqY0olrrgIyp5zT6z0iggOjPLiP2BIMZ1LN5ZCqjyNP
         LZYA==
X-Gm-Message-State: AOAM533oCSLi3/qhw/qMht18Zm8MI1+MbKXdO8KfhYlcCmrsB7H8mYm4
        i8U6eSK3pR8ziN5z/IVcHVD16g==
X-Google-Smtp-Source: ABdhPJzFCUoLGe/zdRGGV12Za77C+HHWpBzk9SrAUn38P4fp0LVimmMsGeqXex9rQxO/w3gPNiIR5A==
X-Received: by 2002:a17:902:be0e:b029:dc:138c:b030 with SMTP id r14-20020a170902be0eb02900dc138cb030mr6509956pls.55.1609976328463;
        Wed, 06 Jan 2021 15:38:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t25sm3851890pgv.30.2021.01.06.15.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 15:38:47 -0800 (PST)
Date:   Wed, 6 Jan 2021 15:38:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: use min() helper for namecmp()
Message-ID: <202101061538.AEF4E09D@keescook>
References: <20210104083221.21184-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104083221.21184-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 05:32:21PM +0900, Masahiro Yamada wrote:
> Make it slightly readable by using min().
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

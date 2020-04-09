Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3DFE1A3A8F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 21:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgDITeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 15:34:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45729 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDITeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:34:12 -0400
Received: by mail-qk1-f196.google.com with SMTP id m67so5247141qke.12;
        Thu, 09 Apr 2020 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xphXmyOdAyfBLtl2H1zTNHLFXlMJZDESiQgsT9iusj4=;
        b=W5YIxCIa0FvZAF5KUoz6XTBkkPe72p6kPsmIp1FEK2ApHmAHP7dt4t8yhfRktVOmFw
         rUvu3/7UVakoLakx/HXkI+WnCbKfog3Tj2N7s5s2oqDWNrxVojjSAEoqSAoo6TXcOWhr
         dEl241eyRnB0NXKudVfa/ZtxKPIUjri9v4epZIAEhGGF5pzPTqbNLlrvlkXoxyeOZIan
         0WegyTDV0l9LCCuMNm28+Wq/X/fp1RnIBRBUMlz+sGJhNB/ekRCZ334lmZINUoed0/yu
         2ZeW/2AG0dzT/U+qtiA8KnwtcE/Q75tNBew7c5AJIyEdhWZmXtEnVCqhxtLua46gS+al
         WpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xphXmyOdAyfBLtl2H1zTNHLFXlMJZDESiQgsT9iusj4=;
        b=VXUc83zfSl/lsSJZgLuJQDY1xd+bJWq3DSYpsVOhy1/fUauBGEDNoOvMHyWtGeveQ1
         iNojI2vwcLnL2qs9IcJnnPBeqrktqS8cYk4ZZLMH+WZFwBqRYi2plhkHxI1SDk1vEOJE
         mMMRYzthB0JdNiB73p/koCI/ivVZ8l4pDZu6WxmEwMIEyR1qWMsPDwptzE9gn3Bw8lqi
         /s1mUm3g3Hab8oQAe1CC9I8ePCuvriWAF5I6bWM9NKXRD4gHAHdgztDmgyz6DrADUD46
         8+mxJblhhB9GK9oGOeUXWxPzr3JY+T5qrebkH62CsFp8lZB8tAcYZhZcIvii/7UElSp4
         mT2Q==
X-Gm-Message-State: AGi0PuY7D9spCFOBavM0+FIPSX55PkCFkJ9qEkhXYMnMMuctnAJZEFnz
        hOTrgnn53IaKDrsH2s2ImBU=
X-Google-Smtp-Source: APiQypKOgC6sOK85of29LP3HC4114KmzmoIcFP76FxvBTzm6IdjeovoPPDR/GwBw54M2YFMMJL57+A==
X-Received: by 2002:a37:61cd:: with SMTP id v196mr454339qkb.393.1586460851903;
        Thu, 09 Apr 2020 12:34:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::74a8])
        by smtp.gmail.com with ESMTPSA id b82sm10719986qkc.13.2020.04.09.12.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 12:34:11 -0700 (PDT)
Date:   Thu, 9 Apr 2020 15:34:10 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     viro@zeniv.linux.org.uk, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] xattr: fix uninitialized out-param
Message-ID: <20200409193410.GD37608@mtj.thefacebook.com>
References: <20200409062729.1658747-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409062729.1658747-1-dxu@dxuuu.xyz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 11:27:29PM -0700, Daniel Xu wrote:
> `removed_sized` isn't correctly initialized (as the doc comment
> suggests) on memory allocation failures. Fix by moving initialization up
> a bit.
> 
> Fixes: 0c47383ba3bd ("kernfs: Add option to enable user xattrs")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Appiled to cgroup/for-5.7-fixes.

Thanks.

-- 
tejun

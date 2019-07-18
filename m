Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8326D684
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 23:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfGRVbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 17:31:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45382 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfGRVbi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:31:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so13179888pfq.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=knozEXRhXWvdO7buD7BicWZWalyyFDnCOXnDxt6wCPU=;
        b=m5PM/hPG+b9HQoKIZGbV+Ijuf2K7lQCUeVE/31Yx0s2UJXJinuR6TELqMMBQe1zNK+
         ITaF4LxTfpVYJT/CB5uauiVzBIPXdmJOiNiHEeLPUYTc8daNjxKKpM+5C/igF5zhrMkY
         /dg5e5/uO7JhNJ/T3J42WAIKkjI6M+DcpIRy3c80cp+0VFInZXxdthcYl6i8hH6m4JNj
         j2V3FyAxSuy5KM7hfAhUZaFUSwuaKxs+KQ+oKowAuYtAOHsfsxVKNnqPIlHfxaTGTwux
         Mi40vng0pTS6OLBl6pMVGG/F1rxxCimHBrEo28sK8by3GCDNubTjdjUIh51eN4R4vbhw
         KMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=knozEXRhXWvdO7buD7BicWZWalyyFDnCOXnDxt6wCPU=;
        b=ilNyJeKfB8m/tglXJN+pIw5qjQB85lrQClHLbGBMAXBM4QKRjbF5+jEUsxlqZzlph7
         AmQJmYlJlXZSHDKdBc0sKrFrFKKc2yj2SXr9dF+8JGuFgrDGtpTkEu5jGdWSj2ZIeIWB
         ASuUwfz+xa9BHTx0gzvBqt6C2ZVi4Spiw/uoL5xI3lr3K+DAOOWfeCo8MBq+A+mdt6oY
         HKjP/fEPsfivuq5x17clhmkZhxDiQ1i8x6n+kGZdHKntLk+mrKQChJU+f9DgyvoGBYTT
         orKaY+HbUU56Pu8mW5vEdsLWqlmrb2OvPF29MhF3H1LOEGg/E74Ywgm2eZxOGE1sWmLi
         vWAQ==
X-Gm-Message-State: APjAAAWIGV3ErZ5IBRa24qGFRUOuGUpVlzsAecoogEuY0phb04Ytbc92
        jlALj6QC2oKS9R0YZpamVqxfZ61Lyh5kkg==
X-Google-Smtp-Source: APXvYqwt4Z+EcKNr4IglRcV9oiMsLHIXxnnhpixhnoN9PRcEQhoL633rKS/P9Lo0QuqjfEkYVbLOgw==
X-Received: by 2002:a63:1305:: with SMTP id i5mr50423942pgl.211.1563485497578;
        Thu, 18 Jul 2019 14:31:37 -0700 (PDT)
Received: from drosen.mtv.corp.google.com ([2620:0:1000:1612:726:adc3:41a6:c383])
        by smtp.gmail.com with ESMTPSA id v3sm26810539pfm.188.2019.07.18.14.31.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 14:31:36 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] f2fs: Support case-insensitive file name lookups
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
References: <20190717031408.114104-1-drosen@google.com>
 <20190717031408.114104-3-drosen@google.com>
 <cbaf59d4-0bd3-6980-4750-fbab14941bdb@huawei.com>
From:   Daniel Rosenberg <drosen@google.com>
Message-ID: <4ef17922-d1e9-1b83-9e89-d332ea6fb7ae@google.com>
Date:   Thu, 18 Jul 2019 14:31:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cbaf59d4-0bd3-6980-4750-fbab14941bdb@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/17/19 3:11 AM, Chao Yu wrote:
> We need to add one more entry f2fs_fsflags_map[] to map F2FS_CASEFOLD_FL to
> FS_CASEFOLD_FL correctly and adapt F2FS_GETTABLE_FS_FL/F2FS_SETTABLE_FS_FL as well.

I don't see FS_CASEFOLD_FL. It would make sense for it to exist, but unless it's in some recent patch I don't think that's currently in the kernel. Or are you suggesting adding it in this patch?


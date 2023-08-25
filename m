Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C38788B81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 16:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbjHYOTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 10:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343759AbjHYOT3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E36426B0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 07:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692973059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vbKQBDak5hl4LAl/oQgyykEHIqEzzDyXxUCIsWAfmDA=;
        b=W7724lB52Bx7G3O49w8+UeoY4QDeex2ANQFVbNryth6/cLnc9LvA6SsSodgUP566m+9jjT
        gQ7J3rjylCeKnPtk2ntK+xQ8klpTFzNQCKSO8CiyNSuKp/6rZcw+njRhs8qs7WX40Qinxq
        04lUgVnTnDw/ZmG7N1ACtvhBAQ0xZmg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-JN9yGH_wMk60J9mRGguFwA-1; Fri, 25 Aug 2023 10:11:36 -0400
X-MC-Unique: JN9yGH_wMk60J9mRGguFwA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-268476c3b2aso2302702a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 07:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972695; x=1693577495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbKQBDak5hl4LAl/oQgyykEHIqEzzDyXxUCIsWAfmDA=;
        b=Xr7Jr5cocdRei7/YaI/voouo4pMlvER61fCbFOzQ4Tk4P3y6vW7oiycVDhG77I9k0l
         9Z6HMQ96UbPNzKYTLs8KTDDMqlBaUuVCKPWRLoFScsde3KeTAVWjRAA1raIiXZCzkwI+
         xioN4lmcW/WqTf9Fo+SN2BYwdV8eNqNGIqm7gm27JSkCaIrFW9/UZhezDgVkaxUTQtm4
         xYbMkkzSXFnWqUhhU50L0IwBqpS1a7NRUhI76zLr8ZvEbB07Q00mTRmOvjAxpAbKf0vm
         B2fnQWzCH/nKUrXKVHyCcbxUaDXCb3wa0+Ledi2T3t2DSdTyOFh+t7xsb+rzPPNIMZ45
         Bjiw==
X-Gm-Message-State: AOJu0YydFMd51oPADI4qiqhNdoH+pxJPbqLqCMacS31GddXX3d9W6GAt
        7WrfYl/LbfTJa3KRIeXVcThiY9FSLKhDcqkcarGFFfh/DY+pwQO2Deeiu52r+J3h1xpAoDBbtJW
        DEO+HBZOXye3NUsqHlLt4KJB52g==
X-Received: by 2002:a17:90b:378f:b0:26b:374f:97c2 with SMTP id mz15-20020a17090b378f00b0026b374f97c2mr27791152pjb.6.1692972690212;
        Fri, 25 Aug 2023 07:11:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Zc5uEZF4xZ2onoUZA2BvHZjsLlVtg14k+brKht9HvqHaz/Zv4GjWBRyj/R5XzcIugOYQqg==
X-Received: by 2002:a17:90b:378f:b0:26b:374f:97c2 with SMTP id mz15-20020a17090b378f00b0026b374f97c2mr27790951pjb.6.1692972687482;
        Fri, 25 Aug 2023 07:11:27 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090ac25800b00263ba6a248bsm3563040pjx.1.2023.08.25.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:11:27 -0700 (PDT)
Date:   Fri, 25 Aug 2023 22:11:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH fstests v2 2/3] generic/513: limit to filesystems that
 support capabilities
Message-ID: <20230825141123.wexv7kuxk75gr5os@zlang-mailbox>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
 <20230824-fixes-v2-2-d60c2faf1057@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-fixes-v2-2-d60c2faf1057@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 24, 2023 at 12:44:18PM -0400, Jeff Layton wrote:
> This test requires being able to set file capabilities which some
> filesystems (namely NFS) do not support. Add a _require_setcap test
> and only run it on filesystems that pass it.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/rc         | 13 +++++++++++++
>  tests/generic/513 |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 5c4429ed0425..33e74d20c28b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5048,6 +5048,19 @@ _require_mknod()
>  	rm -f $TEST_DIR/$seq.null
>  }
>  
> +_require_setcap()
> +{
> +	local testfile=$TEST_DIR/setcaptest.$$
> +
> +	touch $testfile
> +	$SETCAP_PROG "cap_sys_module=p" $testfile > $testfile.out 2>&1

Actually we talked about the capabilities checking helper last year, as below:

https://lore.kernel.org/fstests/20220323023845.saj5en74km7aibdx@zlang-mailbox/

As you bring this discussion back, how about the _require_capabilities() in
above link?

Thanks,
Zorro

> +	if grep -q 'Operation not supported' $testfile.out; then
> +	  _notrun "File capabilities are not supported on this filesystem"
> +	fi
> +
> +	rm -f $testfile $testfile.out
> +}
> +
>  _getcap()
>  {
>  	$GETCAP_PROG "$@" | _filter_getcap
> diff --git a/tests/generic/513 b/tests/generic/513
> index dc082787ae4e..52f9eb916b4a 100755
> --- a/tests/generic/513
> +++ b/tests/generic/513
> @@ -18,6 +18,7 @@ _supported_fs generic
>  _require_scratch_reflink
>  _require_command "$GETCAP_PROG" getcap
>  _require_command "$SETCAP_PROG" setcap
> +_require_setcap
>  
>  _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
> 
> -- 
> 2.41.0
> 


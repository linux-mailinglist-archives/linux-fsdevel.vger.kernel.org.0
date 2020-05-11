Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BB31CE803
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 00:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEKWYN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 18:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgEKWYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 18:24:13 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133C9C061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 15:24:13 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mq3so8542342pjb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 15:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QvaxpqAOG9RnWvaCfYYP2fpuftRhg/t8uSRu7E32TuQ=;
        b=Pe7YR+b338sDJoO+XPIuxNX60nLt75l2VTRDebHqRLmJt9h1yK4Rapmdcyoyh8FrXi
         3FEeVdBp1hFpjkSej5hGNFz5+cCHNg6DeNgMNrCLAOApXzVtZuQi6lIz5zxiKPdwGJ3V
         Syh/TrNkjs76R08MkAtq8MqryvycOESpiNiyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QvaxpqAOG9RnWvaCfYYP2fpuftRhg/t8uSRu7E32TuQ=;
        b=iqk865PhjNQ9lw8PS2K41yuWTkvEeplCFF/EYafst7RtbTTMGxV/q9p31w0Yo9rCp0
         iPFrxKEXCsKAjQm70iglRO7UEeU7vXeNlUAbreCpYOSec3iZhNQbqt9yopi44pnRzjNF
         nvkUNxlZXRYCu5ll73gNl5BlGys8u6nwIhL4it1pcvLUDLEWD2f3WQ3Ee+jUJr0fVx/t
         oPKWhyI2k0JlZLiYaMGmDVz0WyGVdQIUrLieTpgE68rwT2X5ClhfY+Xj2JwiY4EWOpPO
         /jY+lWamJuhamQsZpAxhL4wX/Y1OL6WlRGh19i3hGYDkyBLNT4wLV2Wav4E1Sh9g3dPF
         GD3g==
X-Gm-Message-State: AGi0PuaToY9iZ5+92JsuqepIy2rNDPsVTWCJOS7qphDHD7ue8S4W2yXm
        s12JDA4qUiJ+nakz80BdqSihwg==
X-Google-Smtp-Source: APiQypIqupBdX5IGlXP5mdijDfuVXimMgcwG1qOCb2qRhVNHBZolu5RIdeWlFv/6jCEG2LR8QocOxQ==
X-Received: by 2002:a17:90b:2385:: with SMTP id mr5mr26301393pjb.172.1589235852612;
        Mon, 11 May 2020 15:24:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s123sm10145294pfs.170.2020.05.11.15.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 15:24:11 -0700 (PDT)
Date:   Mon, 11 May 2020 15:24:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 5/5] exec: Move the call of prepare_binprm into
 search_binary_handler
Message-ID: <202005111517.27E34BB6@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <873688zygz.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873688zygz.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 09, 2020 at 02:42:52PM -0500, Eric W. Biederman wrote:
> 
> The code in prepare_binary_handler needs to be run every time
> search_binary_handler is called so move the call into search_binary_handler
> itself to make the code simpler and easier to understand.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yes, nice. :) I don't see any ordering dependencies here. The only thing
I see is a potential for more "work done by kernel before bailing" in
the sense that the arg copying will be performed before we check the
kernel_read() result. I struggle to see how that might be a problem,
and this get us to fewer exec.c exports. Yay!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C4F4B1068
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 15:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbiBJO3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 09:29:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242908AbiBJO3S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:29:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DA4D101
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 06:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644503358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1SQvd3Frvf+fVuKuD/tRHYChDBbnlpyIDB2g2wYB4L0=;
        b=RfRRLxSt0z41yJSIy28jmeeW7s4GVYKIvg1lkVy8HSNylK5XVBJT4h1SD/8cRH79Nd/0YL
        p8y5LPXrqskkrRxlxMxYL9u/8bumncAZeaXr8G81XF2ulftUYAPo4FyFFfZI0yqjia39bt
        ul0dCE7aFqB0O1MEe0ZH/7Df0uy+zFU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-WBZ33z29NEuIezVDAjMNqQ-1; Thu, 10 Feb 2022 09:29:14 -0500
X-MC-Unique: WBZ33z29NEuIezVDAjMNqQ-1
Received: by mail-qk1-f199.google.com with SMTP id d11-20020a37680b000000b0047d87e46f4aso3705159qkc.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 06:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1SQvd3Frvf+fVuKuD/tRHYChDBbnlpyIDB2g2wYB4L0=;
        b=BzFK2BDAVLARq0nZIaD5+pbsphpMKqKpgfv0Rc6xnl6dyCzFXinT+zKFjYO6IFEgBJ
         JExLXeknN/OkdTdsNBBJZcQwWtPiDRFgLZRJuOfpDxd4wMAAArncjHzRWL2tz0kX9jXG
         oBM+e9pjVzWMUVwF0IiQWHpD85Omgl1x/8ri9dC8eYvmj7AXcgSN6xetUH7lzd45PiIh
         zJv9xJ0CqLfZ/CTRaKEwJzPTxgzGKbn+FyQIVItCMxKGowEgLz3wAJ75EDpa66Rw7sSH
         WB6NfK07Vop7MyDFmOROAWlf/OQ9TyTDlaQNExqfp5xEnKCLtGflDoUDpa6Uie/L/NY8
         0wSg==
X-Gm-Message-State: AOAM5319cTZvLusUiV/BhuivF4BTmkdMf4DSSiprwbzvO4p09lkvhrOu
        dDP1fFDRfTuPuX6q8XtJID5/pAz/sDdGAjqnTyIJEOkROImzpxNhGb+8/UNXZAdaA85WdNi4RJd
        QAOObaA6lmQCt9hF0NJa8Vg6C+w==
X-Received: by 2002:a37:6113:: with SMTP id v19mr3943046qkb.143.1644503353941;
        Thu, 10 Feb 2022 06:29:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzthpEAsRmiFSLhf0zYFBx1uwDtyiwp3QzeIkLINx4ujMbK0ZGtCnZKh6bbXAoAd1lL9PNU3Q==
X-Received: by 2002:a37:6113:: with SMTP id v19mr3943034qkb.143.1644503353768;
        Thu, 10 Feb 2022 06:29:13 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id bk23sm9925449qkb.3.2022.02.10.06.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 06:29:13 -0800 (PST)
Message-ID: <c069bb1b0ec50358fc4d093ebd7482c7484d77b4.camel@redhat.com>
Subject: Re: [PATCH RFC v12 1/3] fs/lock: add new callback,
 lm_lock_conflict, to lock_manager_operations
From:   Jeff Layton <jlayton@redhat.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 10 Feb 2022 09:29:12 -0500
In-Reply-To: <20220210142143.GC21434@fieldses.org>
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
         <1644468729-30383-2-git-send-email-dai.ngo@oracle.com>
         <20220210142143.GC21434@fieldses.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-02-10 at 09:21 -0500, J. Bruce Fields wrote:
> Jeff, this table of locking rules seems out of date since 6109c85037e5
> "locks: add a dedicated spinlock to protect i_flctx lists".  Are any of
> those callbacks still called with the i_lock?  Should that column be
> labeled "flc_lock" instead?  Or is that even still useful information?
> 
> --b.


Yeah, that should probably be the flc_lock. I don't think we protect
anything in the file locking code with the i_lock anymore.

> 
> On Wed, Feb 09, 2022 at 08:52:07PM -0800, Dai Ngo wrote:
> > diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> > index d36fe79167b3..57ce0fbc8ab1 100644
> > --- a/Documentation/filesystems/locking.rst
> > +++ b/Documentation/filesystems/locking.rst
> > @@ -439,6 +439,7 @@ prototypes::
> >  	void (*lm_break)(struct file_lock *); /* break_lease callback */
> >  	int (*lm_change)(struct file_lock **, int);
> >  	bool (*lm_breaker_owns_lease)(struct file_lock *);
> > +	bool (*lm_lock_conflict)(struct file_lock *);
> >  
> >  locking rules:
> >  
> > @@ -450,6 +451,7 @@ lm_grant:		no		no			no
> >  lm_break:		yes		no			no
> >  lm_change		yes		no			no
> >  lm_breaker_owns_lease:	no		no			no
> > +lm_lock_conflict:       no		no			no
> >  ======================	=============	=================	=========
> 

-- 
Jeff Layton <jlayton@redhat.com>


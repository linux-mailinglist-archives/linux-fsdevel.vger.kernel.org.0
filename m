Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC946633D2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 23:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbjAIWTC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 17:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjAIWSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:18:36 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122E01208E;
        Mon,  9 Jan 2023 14:18:35 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id v25so15283192lfe.12;
        Mon, 09 Jan 2023 14:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgbO5/6E78JCLwQiRJ+GU76lb3E80co6aQPgv1Rwx3Y=;
        b=cWFBiZsxJmt7+Mr0gxTH1fT682fYZn4nDLSPHWboy0Q+UYXTstHpRkaGBdq/1mvXAZ
         N388+BelXTCuRWYsiegdu4V9/Yj+DXsVD5S7kr6gTACp5oileN0NxVRIl4MxHMvXntwW
         AzyWkacDaj4OMwsjs8ljwc6J07NO76YhYAS8/jcH5klUnKa8dFdR60hYCzZe30rsJXyj
         6fmbwdWcOZ9f3+osuGvy0EVnnTNll8P51LnBoIj1QlO2FE3m8a8uNX9ly1e+jfi4MwMp
         5lebH+h/v8uPxA4K2t8dQbwvj1LagszbLmId1kdgs2KbHby0lYpDxKX5k7wqaoxdsv8t
         sVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgbO5/6E78JCLwQiRJ+GU76lb3E80co6aQPgv1Rwx3Y=;
        b=Qx4z/RR/QF47Y0Mj9G0pktBSHowu/dq9z49ndkJu1IsSZA0Hc/puNPH3ZpVcqmmaKK
         gad+QeeQYLpDwcNtgx0UCP0nhPOCJ70DENamIKYcP1BKnPgw8StQ59K8uVk2EYSG259m
         ReKIxVae0QNfu1sEvCw/+wfIcG/mr1pbCnvVg/9w2vMUvO4iJ5KyQhVo/mF28g/+yQgj
         5CKxMnsNR7LV0/lIdRlxwhFr3qZvAhVqV6ajeCl/JDEw9ySjaB08o5Eqx9vl3a4iZrSl
         mMIhicZxFRAEciltzOLtpVy4jR2LuCyVvx6hGKGtoUuGqPCqQBfq84TjxMEJD+7cLzOw
         /yhw==
X-Gm-Message-State: AFqh2kra4bfUj5CKXas6QEdvW2VvxOa+TrPyHbMYjfy5LiTLA2OLCfrO
        q7+QsPcS2BkeRgtylT4V5GA=
X-Google-Smtp-Source: AMrXdXvvuTXTdr14JdOozdCOiEcAiGITq24w9ufrrPr27Oq0YD+fW7BIb1ASJXK1NPFAzalX26yLYw==
X-Received: by 2002:ac2:43b5:0:b0:4cb:40ba:4ae8 with SMTP id t21-20020ac243b5000000b004cb40ba4ae8mr5990424lfl.34.1673302713261;
        Mon, 09 Jan 2023 14:18:33 -0800 (PST)
Received: from grain.localdomain ([5.18.253.97])
        by smtp.gmail.com with ESMTPSA id w6-20020a056512098600b004b4e67c3c00sm1818091lft.53.2023.01.09.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 14:18:32 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 8A7B15A0020; Tue, 10 Jan 2023 01:18:31 +0300 (MSK)
Date:   Tue, 10 Jan 2023 01:18:31 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, kernel@collabora.com,
        peterx@redhat.com, david@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] mm: implement granular soft-dirty vma support
Message-ID: <Y7ySt0XGnbzTyY6T@grain>
References: <20221220162606.1595355-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220162606.1595355-1-usama.anjum@collabora.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 20, 2022 at 09:26:05PM +0500, Muhammad Usama Anjum wrote:
...
>
> +static inline int nsdr_adjust_new_first(struct vm_area_struct *new, struct vm_area_struct *vma)
> +{
> +	struct non_sd_reg *r, *r_tmp, *reg;
> +	unsigned long mid = vma->vm_start;
> +
> +	list_for_each_entry_safe(r, r_tmp, &vma->non_sd_reg, nsdr_head) {
> +		if (r->start < mid && r->end > mid) {
> +			reg = kmalloc(sizeof(struct non_sd_reg), GFP_KERNEL);
> +			if (!reg)
> +				return -ENOMEM;
> +			reg->start = r->start;
> +			reg->end = mid;
> +			list_add_tail(&reg->nsdr_head, &new->non_sd_reg);
> +
> +			r->start = mid;
> +		} else if (r->end <= mid) {
> +			list_move_tail(&r->nsdr_head, &new->non_sd_reg);
> +		}
> +	}
> +	return 0;
> +}

Hi Muhhamad, really sorry for delay. Please enlighten me here if I get your
idea right -- every new VMA merge might create a new non_sd_seg entry, right?
And this operation will be applied again and again until vma get freed. IOW
we gonna have a chain of non_sd_reg which will be hanging around until VMA
get freed, right?

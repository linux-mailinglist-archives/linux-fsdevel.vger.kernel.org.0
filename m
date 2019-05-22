Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935E7268EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 19:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfEVRNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 13:13:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53833 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfEVRNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 13:13:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so3003749wme.3;
        Wed, 22 May 2019 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CpjgnkF4sruSuOrQ4VHMEk7dF6UBjfXsObBBwsBgqqk=;
        b=RssdoCWhiAKCll53j5tJrIbL+pWXOsqAR4f0hlrGh8aceXkxyZx46Ju4jkAwX5wIxH
         YR0IK0Hk89pV7f9U4P5OUNavZl9TCtoP+2GGSy2wnQjP9ptqrH0Rn5LnsKUj/8pZgiOB
         KWnRciVDNz0ZJCq4h/14nYAoYEOIi7vSD175DD/FqPosHKBiNl+Z5IyoFXoPGlSq7Spg
         EGBfxu0QAUjQMoxznXteUROIoLc6wU86bldO3nxlZCRbhswkDB9WPnWkwt5d2JdVBrSm
         zLqVUad0h2Fyju9ts0sOtoim544kIzY3IIoxK5nPCgQfs/StYvXX43VATZdujBd4/t6Y
         6gnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CpjgnkF4sruSuOrQ4VHMEk7dF6UBjfXsObBBwsBgqqk=;
        b=jd1low4d/rWgZNeXlrEiQTorhPkjrdu6DMaobj75XHGFgfuKBKQ+vtPracTi3XmsrS
         /q7BdVXtTY7Zx3+29W0hF9pdaO8e6Jsu5lEGLkoNombJrG4HbijSDNSNvxWqNio1RfrN
         bBG2RlsWTRMUeQ1g9ou41ZfTPT7teSnm5DPH0fhGfAPKQuWKAMcHNzFZ2ALXHFRsu5Uw
         ZHdpYBvIwUWpGegw5vTHS73iVOavFVjClbhVyZ0U5NqKKUXz9k8FB+IYsgUe0ElcaMfg
         bhBfhK+CBALV3C62Kz3dY6IhPRNHNUrsS9b+8N0BNCZTLQw1Plu329qTZFHHuwubxllG
         /rsg==
X-Gm-Message-State: APjAAAUFbcHcWxXx5I351QxzmdsZm341tlQJUvAjLFjUrA+25c+jq8sA
        1LfG66PV3EHzOcAYMqoKag==
X-Google-Smtp-Source: APXvYqzvtDN4iyZt2JkJqh0kQBV55tVES+dkrB6shRzCZqfEAsBYVLLOO2abqKUNz6rqoWfM6pSvUg==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr8539730wmj.85.1558545210729;
        Wed, 22 May 2019 10:13:30 -0700 (PDT)
Received: from avx2 ([46.53.250.82])
        by smtp.gmail.com with ESMTPSA id a11sm27105190wrx.31.2019.05.22.10.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 10:13:29 -0700 (PDT)
Date:   Wed, 22 May 2019 20:13:27 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Jan Luebbe <jlu@pengutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: report eip and esp for all threads when coredumping
Message-ID: <20190522171327.GA2111@avx2>
References: <20190522161614.628-1-jlu@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190522161614.628-1-jlu@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 06:16:14PM +0200, Jan Luebbe wrote:
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -462,7 +462,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
>  		 * a program is not able to use ptrace(2) in that case. It is
>  		 * safe because the task has stopped executing permanently.
>  		 */
> -		if (permitted && (task->flags & PF_DUMPCORE)) {
> +		if (permitted && (!!mm->core_state)) {

You don't need both "!!" and "()", it is a regular pointer after all.

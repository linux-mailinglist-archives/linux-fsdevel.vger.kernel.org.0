Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0671D183E5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 02:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgCMBKE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 21:10:04 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37751 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCMBKD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:10:03 -0400
Received: by mail-pj1-f65.google.com with SMTP id ca13so3411306pjb.2;
        Thu, 12 Mar 2020 18:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JoS9gKP72CxM9wL/8rqap0rRd7oEMG26UJbDZ6ej9mo=;
        b=KqmYdOKXjvDhXHHXbusj9Xg64lAkRzcxICwiJNytvsA5uvgGGMJTcZlGmR6JY0nxyM
         ct/cBWcojS9O++hECwYqE+pRcyFi8HkUwP2L9C/HsfzThcO9mlwXWzJYYjJMpZd7Qqel
         /AfkrUJ3PSIepByfREAYT64UnkVYntSohGqxirSPa6hkCyYlVVrw967fQPMQO9UKVBEQ
         MlaIXIYwrLW9cAWdg8tax4d2B4cNZitP4+9lu4TtaWQmSQvkGwdbyAsplXYsbIQPkWQf
         D8s85nu/R0bT8bDuam8lVWejYwpJjNMs+6e4Ylz8v764d5JBbVDzq0FHgRB0wej1ZOhu
         FC6A==
X-Gm-Message-State: ANhLgQ3crDRqJ8j6td0QOcvkXGnL3bTQSl1CB2VYSEDrOuDi2xddwmFP
        QJTofA3eW9gTi4EYYJx6iyU=
X-Google-Smtp-Source: ADFU+vtC3CFe+9QrqzySXKbbNCl05Fk+gDPOapW1z0IeEoOULkqqvJDnUzbx3iRiBn+k5DrEOnMQOQ==
X-Received: by 2002:a17:902:7007:: with SMTP id y7mr10431072plk.208.1584061800891;
        Thu, 12 Mar 2020 18:10:00 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w9sm2577359pfd.94.2020.03.12.18.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 18:09:59 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E7ED64028E; Fri, 13 Mar 2020 01:09:58 +0000 (UTC)
Date:   Fri, 13 Mar 2020 01:09:58 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v2 4/4] selftests: kmod: test disabling module autoloading
Message-ID: <20200313010958.GU11244@42.do-not-panic.com>
References: <20200312202552.241885-1-ebiggers@kernel.org>
 <20200312202552.241885-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312202552.241885-5-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 01:25:52PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Test that request_module() fails with -ENOENT when
> /proc/sys/kernel/modprobe contains (a) a nonexistent path, and (b) an
> empty path.
> 
> Case (b) is a regression test for the patch "kmod: make request_module()
> return an error when autoloading is disabled".
> 
> Tested with 'kmod.sh -t 0010 && kmod.sh -t 0011', and also simply with
> 'kmod.sh' to run all kmod tests.
> 
> Note: get_test_count() and get_test_enabled() were broken for test
> numbers above 9 due to awk interpreting a field specification like
> '$0010' as octal rather than decimal.  So I fixed that too.
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: NeilBrown <neilb@suse.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks!

Can you split up the get_test_count()/get_test_enabled() fix into
another patch though? 

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82543F3483
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 17:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfKGQSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 11:18:10 -0500
Received: from helmsgagent01.f-secure.com ([193.110.108.21]:40574 "EHLO
        helmsgagent01.f-secure.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729656AbfKGQSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:18:10 -0500
X-Greylist: delayed 1830 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Nov 2019 11:18:09 EST
Received: from pps.filterd (helmsgagent01.f-secure.com [127.0.0.1])
        by helmsgagent01.f-secure.com (8.16.0.27/8.16.0.27) with SMTP id xA7Fjgfl020076
        for <linux-fsdevel@vger.kernel.org>; Thu, 7 Nov 2019 17:47:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=f-secure.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=msg2048;
 bh=BaRyVHheLgLPyfK8uSvd8uhVPPZZMkiXe73wJg3VPVM=;
 b=I6XKBoZ4dYnjWHMMZIeeLBDt3GVlqzoS+fwC/YneBNvc3zaBuUOQQry3/II4zvCmqjBK
 huZPQMhAo2B24I7QqD2hHj3d3vLFNbl058JIsmcaFRTQHjxRNGeHOENKgsYIypkPwClg
 3aDKMlvjTvfY4So1WcugJV+ViGOCiyFg6+JaWaQPy7d3YsXqjBB6bCEOBxwi0FggN6Jq
 8+Dmc/5Z4BshfaqjA7uHPrgTwJQG75/MsuNchTotEauoGXjqr+tUsloEDKHxdbQEhJP6
 yJYsc3s05EXn5Crwup0QoYXXW4B5MOgcnnKfwVk9TUdFz1sbKTEc7MSib2FkUIgXXYI9 KQ== 
Received: from helex02.fi.f-secure.com ([10.190.48.73])
        by helmsgagent01.f-secure.com with ESMTP id 2w4j8x8cre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2019 17:47:38 +0200
Received: from drapion.f-secure.com (10.128.132.69) by helex01.FI.F-Secure.com
 (10.190.48.70) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 7 Nov
 2019 17:47:38 +0200
From:   Marko Rauhamaa <marko.rauhamaa@f-secure.com>
To:     <linux-fsdevel@vger.kernel.org>
Subject: Can fanotify OPEN_PERM work with CIFS?
Date:   Thu, 7 Nov 2019 17:47:38 +0200
Message-ID: <87r22jk7s5.fsf@drapion.f-secure.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


In a common setup, CIFS file access is tied to the credentials of the
regular Linux user, but the local root has no access. If the local root
monitors such a CIFS mount point with OPEN_PERM, dentry_open() in
fs/notify/fanotify/fanotify_user.c fails with EPERM or EACCES depending
on the kernel version. In effect, the whole mount point becomes
inaccessible to any user.

I understand the question has intricate corner cases and security
considerations, but is the common use case insurmountable? When the
regular user is opening a file for reading and waiting for a permission
to continue, must the file be reopened instead of being "lent" to the
content checker via duping the fd?


Marko

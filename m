Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B25674590D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGCJuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjGCJt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:57 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 402041B6;
        Mon,  3 Jul 2023 02:49:53 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-0b-64a299b42e6c
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel_team@skhynix.com, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 rebased on v6.4 19/25] dept: Apply timeout consideration to swait
Date:   Mon,  3 Jul 2023 18:47:46 +0900
Message-Id: <20230703094752.79269-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5/L/8zl6rQunooujKIosowubxIVfajzoUKICKyo0Q65nFO2
        XJlFmlt201Iwr9S2ai1dWZuEXRRTNHV5KUeusKXSzbzFbKM5u0yjLy8Pv+d5n0+PiJQ+oeeI
        lOpjgkYtV8mwmBIPhptWVBSaFas6G+dDzuVV4PtxnoKSchuG9vtlCGwV6QT01W+HTv8AgmBL
        Gwn5ee0ITD3vSaho8CCosp7F0PFxCrh8wxia8i5hyLhZjuFV/xgBXddyCSiz7wTnVTMBNYEv
        FOT3YSjOzyBC5ysBAUspA5a0xdBrLWJgrCcKmjxvaKh6txwKr3dheFbVREFDZS8BHU9KMHhs
        f2hwNjRS0J6TRcO9ITOGfr+FBItvmIHXNUYCHuhDRedGftPwIquGgHO3HhLgevsUQfX5bgLs
        tjcY6nwDBDjseSSM3qlH0Js9yIDhcoCB4vRsBJcM1yho+/WCBn3XWgj+LMFbovm6gWGS1zuO
        81V+I8U3mzn+cdF7htdXv2N4oz2Zd1iX8Tef9RG8yeujeXvpBczbvbkMf3HQRfBDra0M31gQ
        pPiPrnwiZm6seKNCUCl1gmblpkPiuK/dO5NG8In06u9UGmqmL6IwEceu4Rwlt8n/2tk/MsEx
        u4RzuwMTfAa7kHNkfQ5xsYhkMydz1u8teNyYzu7hOoOZEyGKXcyNGIuZcS1h13G+Nj31r3QB
        V/agZiITFuKffmajcS1l13JdhR48XsqxV8K4zG/dzL+H2dxzq5u6iiRGNKkUSZVqXYJcqVoT
        GZeiVp6IPJyYYEehRVlOj+2rRN723bWIFSFZuMSdalJIablOm5JQizgRKZshyei5oZBKFPKU
        k4Im8aAmWSVoa9FcESWLkKz2H1dI2SPyY0K8ICQJmv8uIQqbk4aS/NHpfY3r21arClKHyNSg
        OifStXU09/UHw5mB5s2q7gj3/tScu/Uxs3SSe/GBDebwmK0mr011Zku2yTndM5o875f4pXKW
        NiHx1I7YukXRR7dVTlp6INNbuGHRh2JdvDZt+/qKiJiZBUX7DI+iY/frfVF7DYFpU10dd3fl
        NpvLFzpllDZOHrWM1GjlfwG8LgDSTQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxiGed9zzntKtebYsXimJmoT48fiB3G4J9EYoz98o4H4xxH3Rxt7
        HJ2laCsM1EWwFUWEiAYrH85STUdKVTwlmXOWMIhIqUKVCswgAvGLgaKUVrH4UTD+eXLlvu9c
        vx4Fo67kZiv0xv2Syag1aIiSVaassSyrK3PoVgZGCJScXAnhseMsVF51EwhcqUHgrsvDMHhr
        E3RFhhFE77YzYCsNIKjqf8RAXXMvAm/1EQIdT2ZAMBxT+EoLCVguXiVwb2gCQ8/Z0xhq5GTw
        n3JgaBh/zoJtkECFzYJj5wWGcaeLB2fuQhioLudhoj8RfL2dHDSd93Hgffg9lP3RQ+Cm18dC
        8/UBDB03Kgn0uj9x4G9uYSFQUsTB5VcOAkMRJwPO8AgP9xvsGGqtMVt+6CMHt4saMORfuoYh
        +N8/COqP92GQ3Z0EmsLDGDxyKQPv/7yFYKD4JQ9HT47zUJFXjKDw6FkW2j/c5sDakwTRd5Vk
        /RraNDzCUKvnN+qN2Fna6hDp3+WPeGqtf8hTu5xJPdVL6cWbg5hWjYY5KrsKCJVHT/P0xMsg
        pq/a2njaci7K0idBG94692flWp1k0GdJphXrdirTXvQl7w2R7Lz612wuauVOoHiFKPwg+odC
        U0yERWJ39zgzyQnCfNFT9CyWKxWMcGyaWP36LpksvhG2iV3RY1MjVlgohuwV/CSrhNViuN3K
        fpHOE2tqG6Y28bH86btiNMlqIUnsKeslp5DSjuJcKEFvzErX6g1Jy8170nKM+uzluzLSZRT7
        GefvEyXX0VjHpkYkKJBmuqr7YJVOzWmzzDnpjUhUMJoElaX/gk6t0mlzDkimjB2mTINkbkRz
        FKxmlmpzqrRTLfyi3S/tkaS9kulrixXxs3PR7ju1HxKWuf6yrQvc6zx86H3J+u1zpxe6C8rO
        7LtiWZUv290RHKno8jQt2P3WZ1hM/PRB0v+LzwxuPKL/7ttZvz5bknkw23u+ZXvKqDG1IIUU
        /dh3//CiaNyWunzHjA3FGQUzbcn/hqIGZ7zc6nrTtqH8bdzET8FyP3shPLzixtjjRA1rTtMm
        LmVMZu1n8BLdTi8DAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to swait, assuming an input 'ret' in ___swait_event()
macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/swait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 02848211cef5..def1e47bb678 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -162,7 +162,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 	struct swait_queue __wait;					\
 	long __ret = ret;						\
 									\
-	sdt_might_sleep_start(NULL);					\
+	sdt_might_sleep_start_timeout(NULL, __ret);			\
 	INIT_LIST_HEAD(&__wait.task_list);				\
 	for (;;) {							\
 		long __int = prepare_to_swait_event(&wq, &__wait, state);\
-- 
2.17.1

